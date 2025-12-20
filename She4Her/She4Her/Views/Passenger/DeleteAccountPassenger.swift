import SwiftUI

struct DeleteAccountView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                        .frame(height: 208)
                    
                    VStack(spacing: 0) {
                        Text("Delete Account?")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.bottom, 12)
                        
                        Text("This will permanently delete your profile on She4Her.")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 79)
                        
                        HStack(spacing: 26) {
                            Button(action: {
                                // No action
                            }) {
                                Text("No")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 117, height: 55)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color(red: 0.467, green: 0, blue: 1, opacity: 0.3), radius: 7, x: 0, y: 4)
                            }
                            
                            NavigationLink(destination: DeleteAccountCompletionPassenger()) {
                                Text("Delete")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 117, height: 55)
                                    .background(Color(red: 0.467, green: 0, blue: 1))
                                    .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            }
                        }
                        .padding(.top, 56)
                    }
                    .frame(width: 308, height: 370)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DeleteAccountView()
}
