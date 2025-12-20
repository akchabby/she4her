import SwiftUI

struct EditingProfileInfoDriver: View {
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
            .padding(.horizontal, 22)
            .padding(.top, 41)
            
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                    .frame(width: 308, height: 439)
                    .overlay(
                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                TextField("First Name", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                TextField("Last Name", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                TextField("Password", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Image(systemName: "eye")
                                                .foregroundColor(.gray)
                                                .padding(.trailing)
                                        }
                                    )
                                
                                TextField("Phone Number", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                TextField("Email", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                
                                TextField("Plate Number", text: .constant(""))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 32)
                        }
                    )
            }
            .padding(.top, 40)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    EditingProfileInfoDriver()
}
