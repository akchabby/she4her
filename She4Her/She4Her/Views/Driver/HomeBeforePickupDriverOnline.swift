import SwiftUI

struct HomeBeforePickupDriverOnline: View {
    @State private var isOnline = false
    
    var body: some View {
        ZStack {
            // Map Background
            Image("map")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 495)
                .offset(x: -111, y: 178)
            
            // Ellipse Overlay
            Circle()
                .fill(Color.black.opacity(0.11))
                .stroke(Color.purple, lineWidth: 2)
                .frame(width: 359, height: 354)
                .offset(x: 13, y: 214)
            
            // Map Indicators
            Group {
                // 10 min indicator
                Circle()
                    .fill(Color.purple)
                    .frame(width: 53, height: 27)
                    .offset(x: 77, y: 278)
                Text("10 min")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium))
                    .offset(x: 83, y: 283)
                
                // 4 min indicator
                Circle()
                    .fill(Color.purple)
                    .frame(width: 53, height: 27)
                    .offset(x: 316, y: 280)
                Text("4 min")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium))
                    .offset(x: 322, y: 285)
                
                // 15 min indicator
                Circle()
                    .fill(Color.purple)
                    .frame(width: 53, height: 27)
                    .offset(x: 137, y: 403)
                Text("15 min")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium))
                    .offset(x: 143, y: 408)
            }
            
            // Bottom Sheet
            VStack {
                Spacer()
                
                VStack {
                    // Online/Offline Toggle
                    HStack {
                        Text("Offline")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(isOnline ? .black : .black)
                        
                        Toggle("", isOn: $isOnline)
                            .labelsHidden()
                        
                        Text("Online")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(isOnline ? .green : .black)
                    }
                    .padding()
                    
                    // Ride Details
                    VStack(alignment: .leading, spacing: 8) {
                        Text("$16")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("20 minute drive")
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.37))
                        
                        Text("15 minutes away")
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.37))
                    }
                    .padding()
                    
                    // Action Buttons
                    HStack {
                        Text("Decline")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Accept")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(54)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    HomeBeforePickupDriverOnline()
}

