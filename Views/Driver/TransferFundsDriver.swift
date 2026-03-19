import SwiftUI

struct TransferFundsDriver: View {
    @State private var amount: String = ""
    @State private var selectedFromAccount = "Earnings Balance"
    @State private var selectedToAccount = "Bank Account"
    @State private var showConfirmAlert = false
    @Environment(\.dismiss) private var dismiss
    
    let fromAccounts = ["Earnings Balance", "Credit Card"]
    let toAccounts = ["Bank Account", "PayPal", "Debit Card"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 32) {
                        balanceCard
                        transferForm
                        confirmButton
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Confirm Transfer", isPresented: $showConfirmAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Confirm") {
                // Handle transfer
                dismiss()
            }
        } message: {
            Text("Transfer $\(amount) from \(selectedFromAccount) to \(selectedToAccount)?")
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            
            Spacer()
            
            Text("Transfer Funds")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                Text("Back")
                    .font(.system(size: 16))
            }
            .opacity(0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(spacing: 16) {
            Text("Available Balance")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text("$205.12")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            
            Text("This Week's Earnings")
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.05), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.467, green: 0, blue: 1).opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Transfer Form
    private var transferForm: some View {
        VStack(spacing: 24) {
            // Amount Input
            VStack(alignment: .leading, spacing: 8) {
                Text("Amount")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                HStack(spacing: 0) {
                    Text("$")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.467, green: 0, blue: 1))
                        .cornerRadius(8, corners: [.topLeft, .bottomLeft])
                    
                    TextField("0.00", text: $amount)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .keyboardType(.decimalPad)
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(8, corners: [.topRight, .bottomRight])
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(amount.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            }
            
            // From Account Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("From")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                Menu {
                    ForEach(fromAccounts, id: \.self) { account in
                        Button(action: {
                            selectedFromAccount = account
                        }) {
                            HStack {
                                Text(account)
                                if selectedFromAccount == account {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedFromAccount)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 50)
                            .background(Color(red: 0.467, green: 0, blue: 1))
                    }
                    .padding(.leading, 16)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
            }
            
            // To Account Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("To")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                Menu {
                    ForEach(toAccounts, id: \.self) { account in
                        Button(action: {
                            selectedToAccount = account
                        }) {
                            HStack {
                                Text(account)
                                if selectedToAccount == account {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedToAccount)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 50)
                            .background(Color(red: 0.467, green: 0, blue: 1))
                    }
                    .padding(.leading, 16)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        Button(action: {
            showConfirmAlert = true
        }) {
            Text("Confirm Transfer")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isFormValid ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                        .shadow(color: isFormValid ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                )
        }
        .disabled(!isFormValid)
    }
    
    private var isFormValid: Bool {
        !amount.isEmpty && Double(amount) ?? 0 > 0
    }
}

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    TransferFundsDriver()
}
