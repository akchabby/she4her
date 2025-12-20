import SwiftUI

struct UploadCarPhotoDriver: View {
    @State private var carName: String = ""
    @State private var carType: String = ""
    @State private var licensePlate: String = ""
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Become a Driver")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 14)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Upload Car Photo")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    
                    Button(action: {
                        // Image picker action
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black.opacity(0.37), lineWidth: 2)
                                .frame(width: 80, height: 72)
                                .background(Color.white)
                            
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 53, height: 49)
                            } else {
                                Image(systemName: "camera")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    TextField("Car Name", text: $carName)
                        .padding()
                        .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                    
                    TextField("Car Type", text: $carType)
                        .padding()
                        .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                    
                    TextField("License Plate #", text: $licensePlate)
                        .padding()
                        .background(Color(red: 0.961, green: 0.961, blue: 0.961))
                }
                
                Button(action: {
                    // Confirm action
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(red: 0.467, green: 0, blue: 1))
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        Text("Confirm")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 149, height: 42)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    UploadCarPhotoDriver()
}

