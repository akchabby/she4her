import SwiftUI

struct DeleteAccountCompletionPassenger: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            .padding(.leading, 22)
            .padding(.top, 41)
            
            VStack(spacing: 16) {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 308, height: 370)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .overlay(
                        VStack(spacing: 12) {
                            Text("Success!")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                            
                            Text("Your account has been permanently deleted.")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }
                    )
                
                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 117, height: 55)
                        .background(Color(red: 0.467, green: 0, blue: 1))
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                }
            }
            .padding(.top, 208 - 41)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DeleteAccountCompletionPassenger()
}
