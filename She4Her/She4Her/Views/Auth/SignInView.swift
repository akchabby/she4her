import SwiftUI

struct SignIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false   // controls navigation
    
    @AppStorage("lastSignInEmail") private var lastSignInEmail = ""
    @AppStorage("isSignedIn") private var isSignedIn = false
    @AppStorage("hasCompletedInitialCredentials") private var hasCompletedInitialCredentials = false
    @AppStorage("userRole") private var userRole = ""

    var body: some View {
        NavigationStack {
            VStack {
                Image("She4HerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 40)
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Email", text: $email)
                            .padding()
                            .frame(height: 37)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(height: 36)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                    }
                    
                    Button(action: {
                        do {
                            // Attempt to read the saved password for this email from Keychain
                            let saved = try KeychainHelper.shared.readString(account: email, service: "com.yourcompany.yourapp.auth")
                            if saved == password {
                                // Save convenience email
                                lastSignInEmail = email
                                // Ensure credentials completion is set if needed
                                if hasCompletedInitialCredentials == false { hasCompletedInitialCredentials = true }
                                // Mark as signed in so EntryView routes to the appropriate home
                                isSignedIn = true
                            } else {
                                print("Invalid credentials")
                            }
                        } catch {
                            print("Keychain read error: \(error.localizedDescription)")
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 39)
                            .background(Color(red: 0.467, green: 0, blue: 1))
                            .cornerRadius(5)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                    
                    // "Don't have an account?" + navigation button
                    HStack {
                        Text("Don't have an account?")
                        Button("Sign up!") {
                            showSignUp = true   // triggers navigation
                        }
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                    .font(.system(size: 12))
                }
                .padding(.horizontal, 47)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear { if !lastSignInEmail.isEmpty { email = lastSignInEmail } }
            
            // Navigation destination setup
            .navigationDestination(isPresented: $showSignUp) {
                SignUp() // Rider/Driver selection page
            }
        }
    }
}

#Preview {
    SignIn()
}
