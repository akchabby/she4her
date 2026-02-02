import SwiftUI

struct DeleteAccountCompletionPassenger: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isSignedIn") private var isSignedIn = true
    @State private var navigateToSignIn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Hidden navigation to SignIn
                NavigationLink(destination: SignIn(), isActive: $navigateToSignIn) {
                    EmptyView()
                }
                .hidden()
                
                // Background
                Color(red: 0.98, green: 0.98, blue: 0.98)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    headerSection
                    
                    Spacer()
                    
                    // Success Card
                    successCard
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 60)
    }
    
    // MARK: - Success Card
    private var successCard: some View {
        VStack(spacing: 32) {
            // Success Icon with Animation
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.green)
            }
            
            // Message
            VStack(spacing: 16) {
                Text("Success!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Your account has been permanently deleted.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Text("We're sorry to see you go. Thank you for using She4her.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            // Continue Button
            Button(action: {
                isSignedIn = false
                dismiss()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    navigateToSignIn = true
                }
            }) {
                Text("Continue")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.467, green: 0, blue: 1))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    )
            }
            .padding(.horizontal, 60)
            .padding(.top, 8)
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 30)
        .frame(maxWidth: 380)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    DeleteAccountCompletionPassenger()
}
