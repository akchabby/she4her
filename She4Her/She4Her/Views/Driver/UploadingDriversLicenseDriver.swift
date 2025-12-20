import SwiftUI

struct UploadingDriversLicense: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Update Drivers License")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 48)
                .padding(.top, 145)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .stroke(Color(red: 0.851, green: 0.851, blue: 0.851), lineWidth: 2)
                        .frame(width: 308, height: 296)
                    
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                                    .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                    .frame(width: 80, height: 72)
                                
                                Image(systemName: "paperclip")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.black)
                            }
                            
                            Text("Upload Drivers License")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        }
                        .padding(.top, 96)
                        
                        Button(action: {}) {
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
                        .padding(.top, 20)
                    }
                }
            }
            .padding(.horizontal, 48)
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    UploadingDriversLicense()
}
