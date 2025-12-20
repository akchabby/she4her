import SwiftUI

struct EditingLicenseDriverView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
            }
            .padding(.horizontal)
            
            Text("My License")
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Rectangle()
                .fill(Color.white)
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .cornerRadius(16)
                .frame(width: 322, height: 314)
                .overlay(
                    VStack {
                        Image("driversLicenseExample")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 271, height: 172)
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Update")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 100, height: 37)
                                .background(Color.purple)
                                .cornerRadius(5)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        }
                    }
                    .padding()
                )
                .padding(.top)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    EditingLicenseDriverView()
}
