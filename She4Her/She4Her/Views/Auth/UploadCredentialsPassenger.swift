import SwiftUI

struct UploadCredentialsPassenger: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Become a Rider")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 48)
                .padding(.top, 40)
            
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .stroke(Color.gray.opacity(0.85), lineWidth: 2)
                    .frame(width: 308, height: 360)
                    .cornerRadius(16)
                    .overlay(
                        VStack(alignment: .leading) {
                            // Photo Upload
                            HStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                    .frame(width: 80, height: 72)
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 39, height: 36)
                                            .foregroundColor(.black)
                                    )
                                
                                Text("Upload Photo")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            }
                            .padding(.top, 28)
                            .padding(.leading, 24)
                            
                            // Driver's License Upload
                            HStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                    .frame(width: 80, height: 72)
                                    .cornerRadius(6)
                                    .overlay(
                                        Image(systemName: "paperclip")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 38, height: 41)
                                            .foregroundColor(.black)
                                    )
                                
                                Text("Upload Drivers License")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            }
                            .padding(.top, 16)
                            .padding(.leading, 24)
                            
                            NavigationLink(destination: HomePassenger()) {
                                Text("Confirm")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 149, height: 42)
                                    .background(Color(red: 0.467, green: 0, blue: 1))
                                    .cornerRadius(5)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 16)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    )
            }
            .padding(.horizontal, 44)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    UploadCredentialsPassenger()
}
