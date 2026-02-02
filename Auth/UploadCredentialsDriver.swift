import SwiftUI
import PhotosUI

struct UploadCredentialsDriver: View {
    @State private var profilePhoto: UIImage?
    @State private var driversLicense: UIImage?
    @State private var showProfileImagePicker = false
    @State private var showLicenseImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showProfileActionSheet = false
    @State private var showLicenseActionSheet = false
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    headerSection
                    uploadCard
                }
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height, alignment: .center)
                .offset(y: -60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationDestination(isPresented: $navigateToHome) {
                HomePageDriver()
            }
        }
        .confirmationDialog("Choose Photo Source", isPresented: $showProfileActionSheet, titleVisibility: .visible) {
            Button("Take Photo") {
                imageSourceType = .camera
                showProfileImagePicker = true
            }
            Button("Choose from Library") {
                imageSourceType = .photoLibrary
                showProfileImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        }
        .confirmationDialog("Choose License Photo Source", isPresented: $showLicenseActionSheet, titleVisibility: .visible) {
            Button("Take Photo") {
                imageSourceType = .camera
                showLicenseImagePicker = true
            }
            Button("Choose from Library") {
                imageSourceType = .photoLibrary
                showLicenseImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showProfileImagePicker) {
            ImagePickerCredentials(image: $profilePhoto, sourceType: imageSourceType)
        }
        .sheet(isPresented: $showLicenseImagePicker) {
            ImagePickerCredentials(image: $driversLicense, sourceType: imageSourceType)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Become a Driver")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("Upload your credentials to continue")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 40)
    }
    
    // MARK: - Upload Card
    private var uploadCard: some View {
        VStack(spacing: 32) {
            uploadButtonsRow
            infoSection
            confirmButton
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
        .background(cardBackground)
        .padding(.horizontal, 24)
    }
    
    // MARK: - Upload Buttons Row
    private var uploadButtonsRow: some View {
        HStack(spacing: 20) {
            UploadPhotoButton(
                image: profilePhoto,
                icon: "camera.fill",
                label: "Upload Your Photo",
                action: { showProfileActionSheet = true }
            )
            .frame(width: 150)
            
            UploadPhotoButton(
                image: driversLicense,
                icon: "doc.text.fill",
                label: "Upload Driver's License",
                action: { showLicenseActionSheet = true }
            )
            .frame(width: 150)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: - Info Section
    private var infoSection: some View {
        VStack(spacing: 8) {
            InfoRow(text: "Clear, well-lit photos work best")
            InfoRow(text: "Ensure all details are visible")
        }
        .padding(.horizontal, 8)
    }
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        Button(action: confirmCredentials) {
            Text("Confirm")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(confirmButtonBackground)
        }
        .disabled(!isFormValid)
    }
    
    // MARK: - Computed Properties
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
    
    private var confirmButtonBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(isFormValid ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
            .shadow(color: isFormValid ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
    }
    
    private var isFormValid: Bool {
        profilePhoto != nil && driversLicense != nil
    }
    
    // MARK: - Actions
    private func confirmCredentials() {
        print("Profile Photo uploaded: \(profilePhoto != nil)")
        print("Driver's License uploaded: \(driversLicense != nil)")
        navigateToHome = true
    }
}

// MARK: - Upload Photo Button Component
struct UploadPhotoButton: View {
    let image: UIImage?
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: action) {
                ZStack {
                    buttonBackground
                    buttonContent
                }
                .frame(width: 120, height: 120)
            }
            
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var buttonBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(borderColor, lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
    }
    
    private var buttonContent: some View {
        Group {
            if let photo = image {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 116, height: 116)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                VStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.system(size: 32))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    
                    Text(icon == "camera.fill" ? "Photo" : "License")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private var borderColor: Color {
        image != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.4)
    }
}

// MARK: - Info Row Component
struct InfoRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

// MARK: - Image Picker for Credentials
struct ImagePickerCredentials: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerCredentials
        
        init(_ parent: ImagePickerCredentials) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.image = originalImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    UploadCredentialsDriver()
}
