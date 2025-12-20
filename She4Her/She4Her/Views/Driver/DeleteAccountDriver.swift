import SwiftUI

struct DeleteAccountDriverView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer().frame(height: 270)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 308, height: 308)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .overlay(
                        VStack(spacing: 10) {
                            Text("Delete Account?")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                            
                            Text("This will permanently delete your profile on She4Her.")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(width: 235)
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    // No action
                                }) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.white)
                                        .frame(width: 117, height: 55)
                                        .shadow(color: Color(red: 0.467, green: 0, blue: 1).opacity(0.3), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            Text("No")
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                        )
                                }
                                
                                Button(action: {
                                    // Delete action
                                }) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(red: 0.467, green: 0, blue: 1))
                                        .frame(width: 117, height: 55)
                                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            Text("Delete")
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                            .padding(.top, 20)
                        }
                    )
            }
        }
    }
}

#Preview {
    DeleteAccountDriverView()
}
