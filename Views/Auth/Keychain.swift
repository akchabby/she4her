import Foundation
import Security

///class for storing, retrieving, and deleting small secrets in the Keychain.
public final class KeychainHelper {
    public static let shared = KeychainHelper()
    
    private init() {}
    /// saves data to the Keychain for a given account and service.
  
    public func save(data: Data, account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        // Delete any existing item
        SecItemDelete(query as CFDictionary)
        
        // Add new item with data
        var attributes = query
        attributes[kSecValueData as String] = data
        
        let status = SecItemAdd(attributes as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// Reads data from the keychain for a given account and service.
    ///
    /// - Parameters:
    ///   - account: The account identifier.
    ///   - service: The service identifier.
    /// - Returns: The data if found  if no item exists.
    /// - Throws: An error if the read operation fails.
    public func read(account: String, service: String) throws -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        switch status {
        case errSecSuccess:
            guard let data = result as? Data else {
                return nil
            }
            return data
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// Deletes data from the Keychain for a given account and service.
    ///
    /// - Parameters:
    ///   - account: The account identifier.
    ///   - service: The service identifier.
    /// - Throws: An error if the delete operation fails.
    public func delete(account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// Convenience method to save a string to the Keychain.
    public func saveString(_ string: String, account: String, service: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw KeychainError.stringEncodingFailed
        }
        try save(data: data, account: account, service: service)
    }
    
    /// Convenience method to read a string from the Keychain.
    public func readString(account: String, service: String) throws -> String? {
        guard let data = try read(account: account, service: service) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// Errors that can be thrown by KeychainHelper.
    public enum KeychainError: Error, LocalizedError {
        case unhandledError(status: OSStatus)
        case stringEncodingFailed
        
        public var errorDescription: String? {
            switch self {
            case .unhandledError(let status):
                if #available(iOS 11.3, macOS 10.13.4, *) {
                    if let message = SecCopyErrorMessageString(status, nil) as String? {
                        return "Keychain error: \(message) (\(status))"
                    }
                }
                return "Keychain error with code: \(status)"
            case .stringEncodingFailed:
                return "String encoding to UTF-8 failed."
            }
        }
    }
}
