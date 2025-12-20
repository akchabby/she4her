import SwiftUI

struct AddingVehicleDriver: View {
    @State private var carName: String = ""
    @State private var carType: String = ""
    @State private var licensePlate: String = ""
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Adding Vehicle")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 20)
                .padding(.horizontal, 48)
            
            ScrollView {
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        .frame(width: 308, height: 476)
                        .overlay(
                            VStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 10) {
                                    TextField("Car Name", text: $carName)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                    
                                    TextField("Car Type", text: $carType)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                    
                                    TextField("License Plate #", text: $licensePlate)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                }
                                .padding(.horizontal, 20)
                                
                                VStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 2, dash: [5]))
                                        .frame(width: 80, height: 72)
                                        .overlay(
                                            Image(systemName: "paperclip")
                                                .foregroundColor(.gray)
                                        )
                                    
                                    Text("Upload Car Photo")
                                        .foregroundColor(.purple)
                                        .font(.system(size: 12, weight: .medium))
                                }
                                
                                Button(action: {
                                    // Confirm action
                                }) {
                                    Text("Confirm")
                                        .foregroundColor(.white)
                                        .frame(width: 149, height: 42)
                                        .background(Color.purple)
                                        .cornerRadius(5)
                                }
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            }
                            .padding()
                        )
                }
                .padding()
            }
        }
    }
}

#Preview {
    AddingVehicleDriver()
}
