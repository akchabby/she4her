import SwiftUI

struct EditingPaymentMethod1Passenger: View {
    @State private var showDeleteAlert = false
    @State private var showAddPaymentSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 24) {
                        currentCardSection
                        addNewSection
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Delete Payment Method", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deletePaymentMethod()
            }
        } message: {
            Text("Are you sure you want to delete this payment method?")
        }
        .sheet(isPresented: $showAddPaymentSheet) {
            AddPaymentMethodPassengerView()
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
            
            Text("My Payment Methods")
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
    
    // MARK: - Current Card Section
    private var currentCardSection: some View {
        VStack(spacing: 16) {
            Text("Current Card")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                creditCardDisplay
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Visa")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("•••• •••• •••• 4242")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Expires")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                        
                        Text("12/25")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 16)
                
                Button(action: {
                    showDeleteAlert = true
                }) {
                    HStack {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 14))
                        Text("Delete Payment Method")
                            .font(.system(size: 15, weight: .semibold))
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red.opacity(0.5), lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red.opacity(0.05))
                            )
                    )
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
            )
        }
    }
    
    // MARK: - Credit Card Display
    private var creditCardDisplay: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.467, green: 0, blue: 1),
                            Color(red: 0.35, green: 0, blue: 0.85)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("VISA")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                Text("•••• •••• •••• 4242")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .tracking(2)
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("CARDHOLDER")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        Text("JOHN DOE")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("EXPIRES")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        Text("12/25")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(24)
        }
        .frame(height: 200)
    }
    
    // MARK: - Add New Section
    private var addNewSection: some View {
        VStack(spacing: 16) {
            Text("Add Payment Method")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 12) {
                addPaymentButton(
                    icon: "creditcard.fill",
                    title: "Add Credit/Debit Card",
                    subtitle: "Visa, Mastercard, Amex"
                )
                
                addPaymentButton(
                    icon: "building.columns.fill",
                    title: "Add Bank Account",
                    subtitle: "Direct bank transfer"
                )
                
                addPaymentButton(
                    icon: "p.circle.fill",
                    title: "Add PayPal",
                    subtitle: "Use your PayPal account"
                )
            }
        }
    }
    
    private func addPaymentButton(icon: String, title: String, subtitle: String) -> some View {
        Button(action: {
            showAddPaymentSheet = true
        }) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
        }
    }
    
    // MARK: - Actions
    private func deletePaymentMethod() {
        print("Deleting payment method...")
        dismiss()
    }
}

// MARK: - Add Payment Method View
struct AddPaymentMethodPassengerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var cardNumber = ""
    @State private var cardHolder = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Card Information")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Number")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "creditcard.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("1234 5678 9012 3456", text: $cardNumber)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(cardNumber.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Cardholder Name")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("John Doe", text: $cardHolder)
                                    .foregroundColor(.black)
                                    .textInputAutocapitalization(.words)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(cardHolder.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Expiry Date")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                TextField("MM/YY", text: $expiryDate)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(expiryDate.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("CVV")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                TextField("123", text: $cvv)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(cvv.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
                    )
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Add Card")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.467, green: 0, blue: 1))
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            )
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationTitle("Add Payment Method")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
    }
}

#Preview {
    EditingPaymentMethod1Passenger()
}
