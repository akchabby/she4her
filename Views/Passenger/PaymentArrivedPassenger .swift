import SwiftUI

struct PaymentArrivedPassenger: View {
    var body: some View {
        ZStack {
            // Subtle background gradient for depth
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.98, blue: 1.0),
                    Color.white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Card
                VStack(spacing: 20) {
                    // Success Header
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.green.opacity(0.15))
                                .frame(width: 56, height: 56)
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(Color(red: 0.197, green: 0.76, blue: 0.31))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Arrived!")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(red: 0.197, green: 0.76, blue: 0.31))
                            Text("You’ve reached your destination.")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                    // Amount
                    VStack(spacing: 6) {
                        Text("Your Total")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        Text("$17.30")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 4)
                    
                    // Actions
                    HStack(spacing: 12) {
                        NavigationLink(destination: TippingPassengerView()) {
                            Text("Split Bill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.467, green: 0, blue: 1))
                                        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                                )
                        }
                        
                        NavigationLink(destination: TippingPassengerView()) {
                            Text("One Bill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.467, green: 0, blue: 1))
                                        .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                                )
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: 320)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
                )
                .padding(.horizontal, 24)
         
                
                Spacer()
            }
        }
    }
}

#Preview {
    PaymentArrivedPassenger()
}

