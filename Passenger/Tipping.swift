import SwiftUI

struct TippingPassengerView: View {
    @State private var selectedTip: String? = nil
    @State private var navigateToConfirmation = false
    @State private var showingCustomTipSheet = false
    @State private var customTipInput: String = ""
    @Environment(\.dismiss) private var dismiss
    
    let tipOptions = ["10%", "15%", "20%", "25%"]
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: PaymentCompletePassenger(), isActive: $navigateToConfirmation) {
                EmptyView()
            }
            .hidden()
            
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 32) {
                        driverInfoCard
                        tipOptionsSection
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
        .sheet(isPresented: $showingCustomTipSheet) {
            CustomTipSheetView(customTipInput: $customTipInput, onDone: {
                let trimmed = customTipInput.trimmingCharacters(in: .whitespacesAndNewlines)
                if let value = Double(trimmed), value >= 0 {
                    selectedTip = "Custom: \(Int(value))%"
                    showingCustomTipSheet = false
                }
            })
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
            
            Text("Add Tip")
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
    
    // MARK: - Driver Info Card
    private var driverInfoCard: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.2), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Martha")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 11))
                            .foregroundColor(.orange)
                        Text("4.9")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.black)
                        Text("•")
                            .foregroundColor(.gray)
                        Text("900 trips")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            
            Text("Show your appreciation for great service!")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
    
    // MARK: - Tip Options Section
    private var tipOptionsSection: some View {
        VStack(spacing: 20) {
            Text("Select Tip Amount")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(tipOptions, id: \.self) { tip in
                    TipButton(text: tip, isSelected: selectedTip == tip) {
                        selectedTip = tip
                    }
                }
                
                TipButton(
                    text: selectedTip?.starts(with: "Custom") == true ? selectedTip! : "Custom",
                    isSelected: selectedTip?.starts(with: "Custom") == true
                ) {
                    customTipInput = ""
                    showingCustomTipSheet = true
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        Button(action: {
            navigateToConfirmation = true
        }) {
            Text("Confirm Tip")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedTip != nil ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                        .shadow(color: selectedTip != nil ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                )
        }
        .disabled(selectedTip == nil)
    }
}

// MARK: - Tip Button Component
struct TipButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isSelected ? .white : Color(red: 0.467, green: 0, blue: 1))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color(red: 0.467, green: 0, blue: 1) : Color.white.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: isSelected ? 0 : 1)
                        )
                        .shadow(color: Color.black.opacity(0.06), radius: 3, x: 0, y: 1)
                )
        }
    }
}

// MARK: - Custom Tip Sheet
struct CustomTipSheetView: View {
    @Binding var customTipInput: String
    let onDone: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Enter Custom Tip")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 0) {
                        TextField("0", text: $customTipInput)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 100)
                        
                        Text("%")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                    )
                }
                .padding(32)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
                )
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: onDone) {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(!customTipInput.isEmpty ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                                .shadow(color: !customTipInput.isEmpty ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                        )
                }
                .disabled(customTipInput.isEmpty)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationTitle("Custom Tip")
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
    TippingPassengerView()
}
