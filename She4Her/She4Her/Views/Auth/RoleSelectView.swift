import SwiftUI

struct RoleSelectView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image("She4HerLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 80)

            Text("Please confirm your account type")
                .font(.headline)
                .padding(.bottom, 10)

            NavigationLink(destination: SignUpPassenger()) {
                Text("Rider")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 45)
                    .background(Color.purple)
                    .cornerRadius(10)
            }

            NavigationLink(destination: SignUpDriver()) {
                Text("Driver")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 45)
                    .background(Color.purple)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Sign Up")
    }
}

#Preview {
    RoleSelectView()
}
