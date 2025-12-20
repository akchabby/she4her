import SwiftUI

struct SignUpDriver: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var isPasswordVisible = false
    
    @AppStorage("lastSignInEmail") private var lastSignInEmail = ""
    @AppStorage("hasCompletedInitialCredentials") private var hasCompletedInitialCredentials = false
    @AppStorage("userRole") private var userRole = ""
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var goHome = false

    // Simple validation
    private var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Become a Driver")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    // 👇 This button now navigates to the passenger sign-up page
                    NavigationLink(destination: SignUpPassenger()) {
                        Text("Sign Up As Rider")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.purple)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                
                VStack(spacing: 16) {
                    Rectangle()
                        .fill(Color.white)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        .cornerRadius(16)
                        .frame(width: 308, height: 439)
                        .overlay(
                            VStack(spacing: 16) {
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(CustomTextFieldStyle())
                                
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(CustomTextFieldStyle())
                                
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .textContentType(.emailAddress)
                                    .textFieldStyle(CustomTextFieldStyle())
                                
                                HStack {
                                    if isPasswordVisible {
                                        TextField("Password", text: $password)
                                            .textContentType(.newPassword)
                                            .textFieldStyle(CustomTextFieldStyle())
                                    } else {
                                        SecureField("Password", text: $password)
                                            .textContentType(.newPassword)
                                            .textFieldStyle(CustomTextFieldStyle())
                                    }
                                    
                                    Button(action: {
                                        isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .keyboardType(.phonePad)
                                    .textFieldStyle(CustomTextFieldStyle())
                            }
                            .padding()
                        )
                }
                .padding(.top, 20)
                
                Button {
                    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

                    // Persist credentials for temporary sign-in
                    lastSignInEmail = trimmedEmail
                    userRole = "driver"
                    hasCompletedInitialCredentials = true
                    do {
                        try KeychainHelper.shared.saveString(trimmedPassword, account: trimmedEmail, service: "com.yourcompany.yourapp.auth")
                    } catch {
                        print("Keychain save error: \(error.localizedDescription)")
                    }
                    // Mark signed in and navigate home
                    isSignedIn = true
                    goHome = true
                } label: {
                    Text("Confirm")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 149, height: 42)
                        .background(isFormValid ? Color.purple : Color.gray)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
                .padding(.top, 20)
                .disabled(!isFormValid)
                
                // Hidden navigation trigger
                NavigationLink("", destination: HomePageDriver(), isActive: $goHome)
                    .hidden()
                
                Spacer()
            }
            .padding()
            .padding(.top, 80)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}

#Preview {
    SignUpDriver()
}
