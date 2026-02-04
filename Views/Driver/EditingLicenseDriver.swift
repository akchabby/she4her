import SwiftUI
import PhotosUI

struct EditingLicenseDriverView: View {
    @State private var licenseImage: UIImage?
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    @State private var showSuccessAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 32) {
                        licenseCard
                        updateInstructions
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .confirmationDialog("Choose Photo Source", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Take Photo") {
                imageSourceType = .camera
                showImagePicker = true
            }
            Button("Choose from Library") {
                imageSourceType = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerLicense(image: $licenseImage, sourceType: imageSourceType)
        }
        .alert("License Updated", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your driver's license has been successfully updated.")
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
            
            Text("My License")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            // Spacer to balance the back button
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 16))
            }
            .opacity(0) // Hidden but maintains layout balance
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - License Card
    private var licenseCard: some View {
        VStack(spacing: 24) {
            // License Image Display
            ZStack {
                licenseImageBackground
                licenseImageContent
            }
            .frame(height: 220)
            
            // Update Button
            Button(action: {
                showActionSheet = true
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 14))
                    Text("Update License Photo")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                )
            }
            
            // Save Button (only shown if image was changed)
            if licenseImage != nil {
                Button(action: {
                    saveUpdatedLicense()
                }) {
                    Text("Save Changes")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                        )
                }
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
    
    private var licenseImageBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(
                licenseImage != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.3),
                lineWidth: 2
            )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(red: 0.97, green: 0.97, blue: 0.97))
            )
    }
    
    private var licenseImageContent: some View {
        Group {
            if let license = licenseImage {
                Image(uiImage: license)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 216)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                // Placeholder for existing license
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Current License")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text("Tap 'Update License Photo' to change")
                        .font(.system(size: 12))
                        .foregroundColor(.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
        }
    }
    
    // MARK: - Update Instructions
    private var updateInstructions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Update Requirements")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            VStack(spacing: 10) {
                InstructionRow(
                    icon: "checkmark.circle.fill",
                    text: "Ensure license is valid and not expired"
                )
                InstructionRow(
                    icon: "checkmark.circle.fill",
                    text: "Photo should be clear and well-lit"
                )
                InstructionRow(
                    icon: "checkmark.circle.fill",
                    text: "All details must be clearly visible"
                )
                InstructionRow(
                    icon: "checkmark.circle.fill",
                    text: "Avoid glare or shadows on the license"
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
        )
    }
    
    // MARK: - Actions
    private func saveUpdatedLicense() {
        // Add your save logic here
        print("Saving updated license photo...")
        print("License image updated: \(licenseImage != nil)")
        
        // Simulate save and show success
        showSuccessAlert = true
    }
}

// MARK: - Instruction Row Component
struct InstructionRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
        }
    }
}

// MARK: - Image Picker for License
struct ImagePickerLicense: UIViewControllerRepresentable {
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
        let parent: ImagePickerLicense
        
        init(_ parent: ImagePickerLicense) {
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
    EditingLicenseDriverView()
}
