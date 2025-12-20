import SwiftUI

struct PaymentProfilePassenger: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.top, 41)
            
            Text("$43.23")
                .font(.system(size: 24, weight: .medium))
                .padding(.top, 84)
                .frame(maxWidth: .infinity, alignment: .center)
                
            HStack(spacing: 20) {
                NavigationLink(destination: TransferFundsView()) {
                    Text("Add Funds")
                        .font(.system(size: 13))
                        .foregroundColor(.purple)
                        .opacity(1)
                }
                .buttonStyle(.plain)
                
                Divider()
                    .frame(height: 17)
                    .opacity(0.37)
                
                NavigationLink(destination: TransferFundsView()) {
                    Text("Transfer")
                        .font(.system(size: 13))
                        .foregroundColor(.purple)
                        .opacity(1)
                }
                .buttonStyle(.plain)
                
                Divider()
                    .frame(height: 17)
                    .opacity(0.37)
                
                Text("Rewards")
                    .font(.system(size: 13))
                    .foregroundColor(.purple)
                    .opacity(1)
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Cards & Accounts")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Visa")
                        .font(.system(size: 12, weight: .bold))
                    
                    Text("Credit card ending in •••• 4562")
                        .font(.system(size: 12, weight: .medium))
                    
                    NavigationLink(destination: EditingPaymentMethod1Passenger()) {
                        Text("Edit")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.purple)
                            .opacity(1) // ensure full opacity
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink(destination: EditingPaymentMethod2Passenger()) {
                        HStack(spacing: 6) {
                            Image(systemName: "plus")
                                .foregroundColor(.purple)
                            Text("Add payment method")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.purple)
                                .opacity(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rewards & Balances")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("Balance")
                        .font(.system(size: 12, weight: .bold))
                    
                    Text("$43.23")
                        .font(.system(size: 12, weight: .medium))
                    
                    Text("Add Funds")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple)
                    
                    Button(action: {}) {
                        Text("Redeem Rewards")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.purple)
                            .cornerRadius(5)
                    }
                }
            }
            .padding(.horizontal, 58)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Transaction History")
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 58)
                .padding(.top, 32)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("$16")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("20 minute drive")
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.7))
                
                Text("Sept. 4 2025")
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(0)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 58)
            .padding(.top, 16)
            
            HStack {
                Text("View More")
                    .font(.system(size: 13))
                    .foregroundColor(.purple)
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.purple)
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    PaymentProfilePassenger()
}
