import Foundation
import CoreLocation

// MARK: - API Service
class APIService {
    static let shared = APIService()
    
    // TODO: Replace with your actual backend URL
    private let baseURL = "https://api.she4her.com/v1"
    
    private init() {}
    
    // MARK: - Authentication
    
    /// Sign in with email and password
    func signIn(email: String, password: String) async throws -> User {
        let endpoint = "\(baseURL)/auth/signin"
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let response: AuthResponse = try await post(endpoint: endpoint, body: body)
        
        // Save token to keychain
        try KeychainHelper.shared.saveString(
            response.token,
            account: "authToken",
            service: "com.she4her.auth"
        )
        
        return response.user
    }
    
    /// Sign up new user
    func signUp(userData: SignUpData) async throws -> User {
        let endpoint = "\(baseURL)/auth/signup"
        let body: [String: Any] = [
            "email": userData.email,
            "password": userData.password,
            "firstName": userData.firstName,
            "lastName": userData.lastName,
            "phoneNumber": userData.phoneNumber,
            "role": userData.role.rawValue
        ]
        
        let response: AuthResponse = try await post(endpoint: endpoint, body: body)
        
        // Save token to keychain
        try KeychainHelper.shared.saveString(
            response.token,
            account: "authToken",
            service: "com.she4her.auth"
        )
        
        return response.user
    }
    
    /// Sign out current user
    func signOut() throws {
        try KeychainHelper.shared.delete(account: "authToken", service: "com.she4her.auth")
    }
    
    // MARK: - Rides
    
    /// Request a new ride
    func requestRide(pickup: Location, dropoff: Location, preferences: RidePreferences?) async throws -> Ride {
        let endpoint = "\(baseURL)/rides/request"
        var body: [String: Any] = [
            "pickup": pickup.toDictionary(),
            "dropoff": dropoff.toDictionary()
        ]
        
        if let preferences = preferences {
            body["preferences"] = preferences.toDictionary()
        }
        
        return try await post(endpoint: endpoint, body: body)
    }
    
    /// Accept a ride (driver)
    func acceptRide(rideId: String) async throws -> Ride {
        let endpoint = "\(baseURL)/rides/\(rideId)/accept"
        return try await post(endpoint: endpoint, body: [:])
    }
    
    /// Cancel a ride
    func cancelRide(rideId: String, reason: String?) async throws {
        let endpoint = "\(baseURL)/rides/\(rideId)/cancel"
        var body: [String: Any] = [:]
        if let reason = reason {
            body["reason"] = reason
        }
        let _: EmptyResponse = try await post(endpoint: endpoint, body: body)
    }
    
    /// Get ride status
    func getRideStatus(rideId: String) async throws -> Ride {
        let endpoint = "\(baseURL)/rides/\(rideId)"
        return try await get(endpoint: endpoint)
    }
    
    /// Complete a ride
    func completeRide(rideId: String) async throws -> Ride {
        let endpoint = "\(baseURL)/rides/\(rideId)/complete"
        return try await post(endpoint: endpoint, body: [:])
    }
    
    // MARK: - Location
    
    /// Update driver location
    func updateDriverLocation(location: CLLocationCoordinate2D, heading: Double?) async throws {
        let endpoint = "\(baseURL)/drivers/location"
        var body: [String: Any] = [
            "latitude": location.latitude,
            "longitude": location.longitude,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        if let heading = heading {
            body["heading"] = heading
        }
        
        let _: EmptyResponse = try await post(endpoint: endpoint, body: body)
    }
    
    /// Get nearby drivers (passenger)
    func getNearbyDrivers(location: CLLocationCoordinate2D, radius: Double = 5000) async throws -> [Driver] {
        let endpoint = "\(baseURL)/passengers/nearby-drivers"
        let params: [String: String] = [
            "latitude": String(location.latitude),
            "longitude": String(location.longitude),
            "radius": String(radius)
        ]
        
        return try await get(endpoint: endpoint, params: params)
    }
    
    /// Get nearby passengers (driver)
    func getNearbyPassengers(location: CLLocationCoordinate2D, radius: Double = 5000) async throws -> [NearbyRideRequest] {
        let endpoint = "\(baseURL)/drivers/nearby-requests"
        let params: [String: String] = [
            "latitude": String(location.latitude),
            "longitude": String(location.longitude),
            "radius": String(radius)
        ]
        
        return try await get(endpoint: endpoint, params: params)
    }
    
    // MARK: - Payments
    
    /// Process payment for completed ride
    func processPayment(rideId: String, amount: Double, tip: Double, paymentMethodId: String) async throws -> PaymentReceipt {
        let endpoint = "\(baseURL)/payments/process"
        let body: [String: Any] = [
            "rideId": rideId,
            "amount": amount,
            "tip": tip,
            "paymentMethodId": paymentMethodId
        ]
        
        return try await post(endpoint: endpoint, body: body)
    }
    
    /// Add payment method
    func addPaymentMethod(cardData: CardData) async throws -> PaymentMethod {
        let endpoint = "\(baseURL)/payments/methods"
        let body: [String: Any] = [
            "cardNumber": cardData.cardNumber,
            "expiryMonth": cardData.expiryMonth,
            "expiryYear": cardData.expiryYear,
            "cvv": cardData.cvv,
            "nameOnCard": cardData.nameOnCard
        ]
        
        return try await post(endpoint: endpoint, body: body)
    }
    
    /// Get payment methods
    func getPaymentMethods() async throws -> [PaymentMethod] {
        let endpoint = "\(baseURL)/payments/methods"
        return try await get(endpoint: endpoint)
    }
    
    // MARK: - User Profile
    
    /// Get user profile
    func getUserProfile() async throws -> User {
        let endpoint = "\(baseURL)/users/me"
        return try await get(endpoint: endpoint)
    }
    
    /// Update user profile
    func updateUserProfile(updates: [String: Any]) async throws -> User {
        let endpoint = "\(baseURL)/users/me"
        return try await put(endpoint: endpoint, body: updates)
    }
    
    /// Upload profile photo
    func uploadProfilePhoto(imageData: Data) async throws -> String {
        let endpoint = "\(baseURL)/users/me/photo"
        // TODO: Implement multipart/form-data upload
        fatalError("Not implemented")
    }
    
    // MARK: - Reviews
    
    /// Submit ride review
    func submitReview(rideId: String, rating: Int, comment: String?) async throws {
        let endpoint = "\(baseURL)/rides/\(rideId)/review"
        var body: [String: Any] = [
            "rating": rating
        ]
        if let comment = comment {
            body["comment"] = comment
        }
        
        let _: EmptyResponse = try await post(endpoint: endpoint, body: body)
    }
    
    // MARK: - Generic Network Methods
    
    private func get<T: Decodable>(endpoint: String, params: [String: String]? = nil) async throws -> T {
        var urlString = endpoint
        
        if let params = params {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            var components = URLComponents(string: urlString)
            components?.queryItems = queryItems
            urlString = components?.url?.absoluteString ?? urlString
        }
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        try addAuthHeader(to: &request)
        
        return try await performRequest(request)
    }
    
    private func post<T: Decodable>(endpoint: String, body: [String: Any]) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        try addAuthHeader(to: &request)
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        return try await performRequest(request)
    }
    
    private func put<T: Decodable>(endpoint: String, body: [String: Any]) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        try addAuthHeader(to: &request)
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        return try await performRequest(request)
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw APIError.serverError(message: errorResponse.message)
            }
            throw APIError.statusCode(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingError(error)
        }
    }
    
    private func addAuthHeader(to request: inout URLRequest) throws {
        if let token = try? KeychainHelper.shared.readString(account: "authToken", service: "com.she4her.auth") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}

// MARK: - API Models

struct AuthResponse: Codable {
    let user: User
    let token: String
}

struct User: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let role: UserRole
    let profileImageURL: String?
    let rating: Double?
    let tripCount: Int?
}

enum UserRole: String, Codable {
    case driver
    case passenger
}

struct SignUpData {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let role: UserRole
}

struct Ride: Codable {
    let id: String
    let passengerId: String
    let driverId: String?
    let pickupLocation: Location
    let dropoffLocation: Location
    let status: RideStatus
    let fare: Double
    let estimatedDuration: TimeInterval?
    let estimatedDistance: Double?
    let createdAt: Date
    let updatedAt: Date
}

enum RideStatus: String, Codable {
    case requested
    case accepted
    case driverEnRoute
    case arrived
    case inProgress
    case completed
    case cancelled
}

struct NearbyRideRequest: Codable {
    let id: String
    let passengerId: String
    let pickupLocation: Location
    let dropoffLocation: Location
    let createdAt: Date
    let notes: String?
    let preferences: RidePreferences?
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let address: String?
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude
        ]
        if let address = address {
            dict["address"] = address
        }
        return dict
    }
}

struct RidePreferences: Codable {
    let allowKids: Bool?
    let allowPets: Bool?
    let allowPartners: Bool?
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let allowKids = allowKids { dict["allowKids"] = allowKids }
        if let allowPets = allowPets { dict["allowPets"] = allowPets }
        if let allowPartners = allowPartners { dict["allowPartners"] = allowPartners }
        return dict
    }
}

struct Driver: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let rating: Double
    let tripCount: Int
    let vehicleInfo: VehicleInfo?
    let location: Location
}

struct VehicleInfo: Codable {
    let make: String
    let model: String
    let color: String
    let plateNumber: String
    let year: Int?
}

struct PaymentReceipt: Codable {
    let id: String
    let rideId: String
    let amount: Double
    let tip: Double
    let total: Double
    let timestamp: Date
}

struct PaymentMethod: Codable {
    let id: String
    let type: String
    let last4: String
    let expiryMonth: Int
    let expiryYear: Int
}

struct CardData {
    let cardNumber: String
    let expiryMonth: Int
    let expiryYear: Int
    let cvv: String
    let nameOnCard: String
}

struct ErrorResponse: Codable {
    let message: String
    let code: String?
}

struct EmptyResponse: Codable {}

// MARK: - API Errors

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case serverError(message: String)
    case decodingError(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .statusCode(let code):
            return "Server returned status code \(code)"
        case .serverError(let message):
            return message
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .noData:
            return "No data received from server"
        }
    }
}

