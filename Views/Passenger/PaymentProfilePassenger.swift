import SwiftUI

struct PaymentProfilePassenger: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAddFunds = false
    @State private var showTransfer = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: .spacing24) {
                    // Balance Card
                    balanceCard
                    
                    // Quick Actions
                    quickActionsRow
                    
                    // Cards & Accounts
                    cardsSection
                    
                    // Rewards & Balance
                    rewardsSection
                    
                    // Transaction History
                    transactionHistorySection
                }
                .padding(.horizontal, .spacing20)
                .padding(.top, .spacing16)
                .padding(.bottom, .spacing32)
            }
            .background(Color.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.textPrimary)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Payments")
                        .font(.headerSmall)
                }
            }
        }
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(spacing: .spacing12) {
            Text("Available Balance")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
            
            Text("$43.23")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.spacing24)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white.opacity(0.9))
        )
        .foregroundColor(.white)
        .cardShadow()
    }
    
    // MARK: - Quick Actions
    private var quickActionsRow: some View {
        HStack(spacing: .spacing16) {
            QuickActionButton(icon: "plus.circle.fill", title: "Add Funds") {
                showAddFunds = true
            }
            
            QuickActionButton(icon: "arrow.left.arrow.right", title: "Transfer") {
                showTransfer = true
            }
            
            QuickActionButton(icon: "gift.fill", title: "Rewards") {
                // Rewards action
            }
        }
    }
    
    // MARK: - Cards Section
    private var cardsSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Cards & Accounts")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            VStack(alignment: .leading, spacing: .spacing12) {
                HStack {
                    VStack(alignment: .leading, spacing: .spacing4) {
                        Text("Visa")
                            .font(.bodyLarge)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)
                        
                        Text("Credit card ending in •••• 4562")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: EditingPaymentMethod1Passenger()) {
                        Text("Edit")
                            .font(.buttonSmall)
                            .foregroundColor(.brandPurple)
                    }
                }
                
                Divider()
                
                NavigationLink(destination: EditingPaymentMethod2Passenger()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.brandPurple)
                        Text("Add payment method")
                            .font(.bodyMedium)
                            .foregroundColor(.brandPurple)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Rewards Section
    private var rewardsSection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            Text("Rewards & Balance")
                .font(.headerSmall)
                .foregroundColor(.textPrimary)
            
            HStack {
                VStack(alignment: .leading, spacing: .spacing4) {
                    Text("Current Balance")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                    
                    Text("$43.23")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.textPrimary)
                }
                
                Spacer()
                
                Button(action: { showAddFunds = true }) {
                    Text("Add Funds")
                        .font(.buttonSmall)
                        .foregroundColor(.brandPurple)
                }
            }
            
            Divider()
            
            PrimaryButton(title: "Redeem Rewards") {
                // Redeem rewards action
            }
            .frame(height: 44)
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
    
    // MARK: - Transaction History
    private var transactionHistorySection: some View {
        VStack(alignment: .leading, spacing: .spacing16) {
            HStack {
                Text("Transaction History")
                    .font(.headerSmall)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: .spacing4) {
                        Text("View More")
                            .font(.bodySmall)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.brandPurple)
                }
            }
            
            VStack(spacing: .spacing12) {
                TransactionRow(amount: "$16", description: "20 minute drive", date: "Sept. 4 2025")
                Divider()
                TransactionRow(amount: "$20", description: "24 minute drive", date: "Sept. 4 2025")
                Divider()
                TransactionRow(amount: "$26", description: "28 minute drive", date: "Sept. 4 2025")
            }
        }
        .padding(.spacing20)
        .background(
            RoundedRectangle(cornerRadius: .radiusLarge)
                .fill(Color.white)
                .cardShadow()
        )
    }
}

// MARK: - Quick Action Button
struct QuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: .spacing8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.brandPurple)
                
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, .spacing16)
            .background(
                RoundedRectangle(cornerRadius: .radiusLarge)
                    .fill(Color.white)
                    .cardShadow()
            )
        }
    }
}

// MARK: - Transaction Row
struct TransactionRow: View {
    let amount: String
    let description: String
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .spacing4) {
                Text(amount)
                    .font(.bodyLarge)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
                
                Text(description)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
                
                Text(date)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.textSecondary)
            }
        }
    }
}

#Preview {
    PaymentProfilePassenger()
}
