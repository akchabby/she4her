import SwiftUI

struct PaymentProfileDriver: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }

                Spacer()          // pushes content to the edges

          
            }
            .padding(.horizontal, 22)
            .padding(.top, 41)

            
            Text("$221.12")
                .font(.system(size: 24, weight: .medium))
                .padding(.top, 42)
            
            HStack(spacing: 20) {
                Text("Add Funds")
                    .font(.system(size: 13))
                
                Divider()
                    .frame(height: 15)
                    .opacity(0.37)
                
                Text("Transfer")
                    .font(.system(size: 13))
                
                Divider()
                    .frame(height: 15)
                    .opacity(0.37)
                
                Text("Balance")
                    .font(.system(size: 13))
            }
            .padding(.top, 18)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Cards & Accounts")
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        Text("Visa")
                            .font(.system(size: 12, weight: .bold))
                        
                        Spacer()
                        
                        Text("Edit")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.purple)
                    }
                    .padding(.top, 10)
                    
                    Text("Credit card ending in •••• 4562")
                        .font(.system(size: 12, weight: .medium))
                    
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                        
                        Text("Add payment method")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.purple)
                    }
                    .padding(.top, 10)
                }
                
                VStack(alignment: .leading) {
                    Text("Rewards & Balances")
                        .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        Text("$221.12")
                            .font(.system(size: 12, weight: .medium))
                        
                        Spacer()
                        
                        Text("Add Funds")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.purple)
                    }
                    .padding(.top, 10)
                    
                    Button(action: {}) {
                        Text("Redeem Rewards")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.purple)
                            .cornerRadius(5)
                    }
                    .padding(.top, 10)
                }
            }
            .padding(.horizontal, 55)
            .padding(.top, 30)
            
            Text("Transaction History")
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 55)
                .padding(.top, 30)
            
            ScrollView {
                VStack(spacing: 10) {
                    TransactionCard(amount: "$16", duration: "20 minute drive", date: "Sept. 4 2025")
                    TransactionCard(amount: "$20", duration: "24 minute drive", date: "Sept. 4 2025")
                    TransactionCard(amount: "$26", duration: "28 minute drive", date: "Sept. 4 2025")
                }
                .padding(.horizontal, 57)
                .padding(.top, 10)
            }
            
            Button(action: {}) {
                Image(systemName: "chevron.down")
                    .foregroundColor(.black.opacity(0.44))
                    .frame(width: 45, height: 45)
            }
            .padding(.top, 20)
        }
    }
}

struct TransactionCard: View {
    let amount: String
    let duration: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(amount)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(duration)
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.37))
                    
                    Text(date)
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.37))
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    PaymentProfileDriver()
}



