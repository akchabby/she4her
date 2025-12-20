import SwiftUI

struct EditingProfileInfoPassenger: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var plateNumber = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.top, 41)
            
            ScrollView {
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                        .background(Color.white)
                        .frame(width: 308, height: 506)
                        .overlay(
                            VStack(spacing: 16) {
                                TextField("First Name", text: $firstName)
                                    .textFieldStyle(PassengerTextFieldStyle())
                                
                                TextField("Last Name", text: $lastName)
                                    .textFieldStyle(PassengerTextFieldStyle())
                                
                                HStack {
                                    TextField("Password", text: $password)
                                        .textFieldStyle(PassengerTextFieldStyle())
                                        .textContentType(.password)
                                        .keyboardType(.default)
                                        .autocapitalization(.none)
                                    
                                    Button(action: {
                                        isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .textFieldStyle(PassengerTextFieldStyle())
                                    .keyboardType(.phonePad)
                                
                                TextField("Email", text: $email)
                                    .textFieldStyle(PassengerTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                
                                TextField("Plate Number", text: $plateNumber)
                                    .textFieldStyle(PassengerTextFieldStyle())
                            }
                            .padding()
                        )
                    
                    Button(action: {}) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(width: 117, height: 55)
                            .background(Color.purple)
                            .cornerRadius(5)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct PassengerTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(0)
            .font(.system(size: 12))
    }
}

#Preview {
    EditingProfileInfoPassenger()
}
