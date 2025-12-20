import SwiftUI

struct UploadCredentialsDriver: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Become a Driver")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 43)
                .padding(.top, 198)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .stroke(Color.gray.opacity(0.85), lineWidth: 2)
                        .frame(width: 308, height: 392)
                    
                    VStack {
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                    .frame(width: 80, height: 72)
                                    .overlay(
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 39, height: 36)
                                            .foregroundColor(.black)
                                    )
                                
                                Text("Upload Your Photo")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            }
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                                    .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                    .frame(width: 80, height: 72)
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
                        }
                        .padding(.top, 64)
                        
                        NavigationLink(destination: HomePageDriver()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 149, height: 42)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                
                                Text("Confirm")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 45)
                    }
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 43)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    UploadCredentialsDriver()
}
