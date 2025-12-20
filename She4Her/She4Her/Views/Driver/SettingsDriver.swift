import SwiftUI

struct SettingsDriver: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
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
                    .padding(.top, 41)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: 308, height: 332)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .overlay(
                            VStack(alignment: .leading, spacing: 20) {
                                NavigationLink(destination: ProfileDriverView()) {
                                    Text("Edit Profile")
                                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                
                                NavigationLink(destination: EditingLicenseDriverView()) {
                                    Text("Update License")
                                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                
                                NavigationLink(destination: DeleteAccountDriverView()) {
                                    Text("Delete Account")
                                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                        .font(.system(size: 20, weight: .medium))
                                }
                            }
                            .padding()
                        )
                        .padding(.top, 67)
                    
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .frame(width: 32, height: 32)
                        }
                    }
                    .padding(.top, 234)
                    .padding(.trailing, 56)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    SettingsDriver()
}

