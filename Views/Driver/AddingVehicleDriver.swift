import SwiftUI
import PhotosUI

struct AddingVehicleDriver: View {
    @State private var carName: String = ""
    @State private var carType: String = ""
    @State private var licensePlate: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    headerSection
                    vehicleCard
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
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
            ImagePickerVehicle(image: $selectedImage, sourceType: imageSourceType)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Adding Vehicle")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("Enter your vehicle details")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
    
    // MARK: - Vehicle Card
    private var vehicleCard: some View {
        VStack(spacing: 24) {
            vehicleDetailsSection
            uploadPhotoSection
            confirmButton
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
        .background(cardBackground)
        .padding(.horizontal, 24)
    }
    
    // MARK: - Vehicle Details Section
    private var vehicleDetailsSection: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Car Name")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                
                TextField("e.g., Toyota Camry", text: $carName)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(carName.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Car Type")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                
                TextField("e.g., Sedan", text: $carType)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(carType.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("License Plate Number")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                
                TextField("e.g., ABC-1234", text: $licensePlate)
                    .padding()
                    .foregroundColor(.black)
                    .textInputAutocapitalization(.characters)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(licensePlate.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
    
    // MARK: - Upload Photo Section
    private var uploadPhotoSection: some View {
        VStack(spacing: 12) {
            Text("Car Photo")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                showActionSheet = true
            }) {
                ZStack {
                    photoButtonBackground
                    photoButtonContent
                }
                .frame(height: 180)
            }
        }
    }
    
    private var photoButtonBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(
                selectedImage != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.4),
                lineWidth: 2
            )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
    }
    
    private var photoButtonContent: some View {
        Group {
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
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        Button(action: confirmVehicle) {
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
        !carName.isEmpty && !carType.isEmpty && !licensePlate.isEmpty && selectedImage != nil
    }
    
    // MARK: - Actions
    private func confirmVehicle() {
        print("Car Name: \(carName)")
        print("Car Type: \(carType)")
        print("License Plate: \(licensePlate)")
        print("Image uploaded: \(selectedImage != nil)")
        
        // Add your save/navigation logic here
        // Example: Save to database, navigate back, etc.
        dismiss()
    }
}

// MARK: - Image Picker for Vehicle
struct ImagePickerVehicle: UIViewControllerRepresentable {
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
        let parent: ImagePickerVehicle
        
        init(_ parent: ImagePickerVehicle) {
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
    AddingVehicleDriver()
}
