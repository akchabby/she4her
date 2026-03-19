import SwiftUI

struct EditingProfileInfoPassenger: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var plateNumber: String = ""
    @State private var showPassword: Bool = false
    @State private var showSuccessAlert: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 32) {
                        profileInfoCard
                        saveButton
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Profile Updated", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your profile information has been successfully updated.")
        }
        .onAppear {
            loadUserData()
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            
            Spacer()
            
            Text("Edit Profile")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 16))
            }
            .opacity(0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Profile Info Card
    private var profileInfoCard: some View {
        VStack(spacing: 20) {
            Text("Personal Information")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                InputFieldPassenger(
                    label: "First Name",
                    placeholder: "Enter first name",
                    text: $firstName,
                    icon: "person.fill"
                )
                
                InputFieldPassenger(
                    label: "Last Name",
                    placeholder: "Enter last name",
                    text: $lastName,
                    icon: "person.fill"
                )
                
                InputFieldPassenger(
                    label: "Email",
                    placeholder: "Enter email address",
                    text: $email,
                    icon: "envelope.fill",
                    keyboardType: .emailAddress,
                    autocapitalization: .never
                )
                
                InputFieldPassenger(
                    label: "Phone Number",
                    placeholder: "(123) 456-7890",
                    text: $phoneNumber,
                    icon: "phone.fill",
                    keyboardType: .phonePad
                )
                
                PasswordInputFieldPassenger(
                    label: "Password",
                    placeholder: "Enter new password",
                    text: $password,
                    showPassword: $showPassword
                )
                
                InputFieldPassenger(
                    label: "License Plate Number",
                    placeholder: "ABC-1234",
                    text: $plateNumber,
                    icon: "car.fill",
                    autocapitalization: .never,
                    onChange: { newValue in
                        plateNumber = newValue.uppercased()
                    }
                )
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
    
    // MARK: - Save Button
    private var saveButton: some View {
        Button(action: saveProfile) {
            Text("Save Changes")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isFormValid ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                        .shadow(color: isFormValid ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                )
        }
        .disabled(!isFormValid)
    }
    
    // MARK: - Computed Properties
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phoneNumber.isEmpty
    }
    
    // MARK: - Actions
    private func loadUserData() {
        firstName = "Jane"
        lastName = "Doe"
        email = "jane.doe@example.com"
        phoneNumber = "(123) 456-7890"
        plateNumber = "XYZ-5678"
    }
    
    private func saveProfile() {
        print("Saving profile...")
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(email)")
        print("Phone: \(phoneNumber)")
        print("Plate: \(plateNumber)")
        
        showSuccessAlert = true
    }
}

// MARK: - Input Field Component
struct InputFieldPassenger: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var icon: String = ""
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .words
    var onChange: ((String) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
            
            HStack(spacing: 12) {
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .frame(width: 20)
                }
                
                TextField(placeholder, text: $text)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autocapitalization)
                    .onChange(of: text) { newValue in
                        onChange?(newValue)
                    }
            }
            .padding()
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(text.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
            )
        }
    }
}

// MARK: - Password Input Field Component
struct PasswordInputFieldPassenger: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
            
            HStack(spacing: 12) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    .frame(width: 20)
                
                if showPassword {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.black)
                        .textInputAutocapitalization(.never)
                } else {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(text.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    EditingProfileInfoPassenger()
}
