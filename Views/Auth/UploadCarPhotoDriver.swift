import SwiftUI
import PhotosUI

struct UploadCarPhotoDriver: View {
    @State private var carName: String = ""
    @State private var carType: String = ""
    @State private var licensePlate: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                Text("Become a Driver")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                // Upload Car Photo Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Upload Car Photo")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    
                    Button(action: {
                        showActionSheet = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    selectedImage != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.4),
                                    lineWidth: 2
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                )
                                .frame(height: 180)
                            
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 176)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    
                                    Text("Tap to upload photo")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.gray)
                                    
                                    Text("Camera or Photo Library")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray.opacity(0.7))
                                }
                            }
                        }
                    }
                }
                
                // Car Details Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Car Details")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    // Car Name
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Car Name")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextField("e.g., Toyota Camry", text: $carName)
                            .padding()
                            .foregroundColor(.black) // ✅ Black text
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(carName.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // Car Type
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Car Type")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextField("e.g., Sedan", text: $carType)
                            .padding()
                            .foregroundColor(.black) // ✅ Black text
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(carType.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // License Plate
                    VStack(alignment: .leading, spacing: 6) {
                        Text("License Plate Number")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextField("e.g., ABC-1234", text: $licensePlate)
                            .padding()
                            .foregroundColor(.black) // ✅ Black text
                            .textInputAutocapitalization(.characters)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(licensePlate.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                
                Spacer(minLength: 40)
                
                // Confirm Button
                Button(action: {
                    // Validate and confirm action
                    confirmCarDetails()
                }) {
                    HStack {
                        Spacer()
                        Text("Confirm")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isFormValid ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                            .shadow(color: isFormValid ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                    )
                }
                .disabled(!isFormValid)
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
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
            ImagePicker(image: $selectedImage, sourceType: imageSourceType)
        }
    }
    
    private var isFormValid: Bool {
        !carName.isEmpty && !carType.isEmpty && !licensePlate.isEmpty && selectedImage != nil
    }
    
    private func confirmCarDetails() {
        // Add your confirmation logic here
        print("Car Name: \(carName)")
        print("Car Type: \(carType)")
        print("License Plate: \(licensePlate)")
        print("Image uploaded: \(selectedImage != nil)")
        
        // Navigate to next screen or save data
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
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
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
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
    UploadCarPhotoDriver()
}
