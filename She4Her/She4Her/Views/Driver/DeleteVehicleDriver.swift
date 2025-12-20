import SwiftUI

struct DeleteVehicleDriver: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 208)
                
                VStack(spacing: 0) {
                    Text("Delete Tracker SUV?")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 77)
                    
                    Text("This will permanently delete the vehicle Tracker SUV on She4Her.")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                    
                    HStack(spacing: 26) {
                        Button(action: {
                            // No action
                        }) {
                            Text("No")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                .frame(width: 117, height: 55)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color(red: 0.467, green: 0, blue: 1, opacity: 0.3), radius: 7, x: 0, y: 4)
                        }
                        
                        Button(action: {
                            // Delete action
                        }) {
                            Text("Delete")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 117, height: 55)
                                .background(Color(red: 0.467, green: 0, blue: 1))
                                .cornerRadius(5)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, x: 0, y: 4)
                        }
                    }
                    .padding(.top, 55)
                }
                .frame(width: 308, height: 370)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, x: 0, y: 4)
                
                Spacer()
            }
        }
    }
}

#Preview {
    DeleteVehicleDriver()
}
