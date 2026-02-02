import SwiftUI
import UIKit

struct UploadingDriversLicenseDriver: View {
    @State private var selectedImage: UIImage?
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
                        instructionCard
                        uploadSection
                        requirementsSection
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
        .confirmationDialog("Choose Photo Source", isPresented: $showActionSheet) {
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
            ImagePickerLicenseDriver(image: $selectedImage, sourceType: imageSourceType)
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
            
            Text("Update Driver's License")
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
    
    // MARK: - Instruction Card
    private var instructionCard: some View {
        HStack(spacing: 12) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text("Please upload a clear photo of your driver's license")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
        )
    }
    
    // MARK: - Upload Section
    private var uploadSection: some View {
        VStack(spacing: 20) {
            Text("Driver's License Photo")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                showActionSheet = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 0.467, green: 0, blue: 1).opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [10]))
                        .frame(height: 220)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                        )
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            }
                            
                            VStack(spacing: 6) {
                                Text("Upload License Photo")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text("Tap to take a photo or choose from library")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
    
    // MARK: - Requirements Section
    private var requirementsSection: some View {
        VStack(spacing: 16) {
            Text("Photo Requirements")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                RequirementRow(text: "License must be valid and not expired")
                RequirementRow(text: "All text must be clearly visible")
                RequirementRow(text: "No glare or shadows on the license")
                RequirementRow(text: "Photo must be in color")
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Save Button
    private var saveButton: some View {
        Button(action: {
            saveLicense()
        }) {
            Text("Save Changes")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedImage != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                        .shadow(color: selectedImage != nil ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                )
        }
        .disabled(selectedImage == nil)
    }
    
    // MARK: - Actions
    private func saveLicense() {
        print("Saving license...")
        showSuccessAlert = true
    }
}

// MARK: - Requirement Row Component
struct RequirementRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 16))
                .foregroundColor(.green)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

// MARK: - Image Picker
struct ImagePickerLicenseDriver: UIViewControllerRepresentable {
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
        let parent: ImagePickerLicenseDriver
        
        init(_ parent: ImagePickerLicenseDriver) {
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
    UploadingDriversLicenseDriver()
}
