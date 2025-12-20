import SwiftUI

struct SignUp: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Image("She4HerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .padding(.top, -90)
                
                VStack(spacing: 20) {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 308, height: 230)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                        )
                        .overlay(
                            VStack {
                                Text("Please confirm your account type.")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding(.top, 24)
                                
                                // ✅ Rider button -> Passenger sign-up
                                NavigationLink(destination: SignUpPassenger()) {
                                    Text("Rider")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: 220, height: 39)
                                        .background(Color(red: 0.467, green: 0, blue: 1))
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                                }
                                .padding(.top, 16)
                                
                                // ✅ Driver button -> Driver sign-up
                                NavigationLink(destination: SignUpDriver()) {
                                    Text("Driver")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: 220, height: 39)
                                        .background(Color(red: 0.467, green: 0, blue: 1))
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                                }
                                .padding(.top, 10)
                            }
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SignUp()
}
