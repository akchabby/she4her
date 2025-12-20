import SwiftUI

struct TippingPassengerView: View {
    @State private var selectedTip: String? = nil
    @State private var navigateToConfirmation = false
    @State private var showingCustomTipSheet = false
    @State private var customTipInput: String = ""
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PaymentCompletePassenger(), isActive: $navigateToConfirmation) { EmptyView() }.hidden()
            
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack(spacing: 24) {
                    TipButtonView(text: "10%", isSelected: selectedTip == "10%")
                        .onTapGesture { selectedTip = "10%" }
                    TipButtonView(text: "15%", isSelected: selectedTip == "15%")
                        .onTapGesture { selectedTip = "15%" }
                }
                HStack(spacing: 24) {
                    TipButtonView(text: "20%", isSelected: selectedTip == "20%")
                        .onTapGesture { selectedTip = "20%" }
                    TipButtonView(text: "Custom", isSelected: selectedTip?.starts(with: "Custom") == true)
                        .onTapGesture {
                            customTipInput = ""
                            showingCustomTipSheet = true
                        }
                }
                ConfirmButtonView(isEnabled: selectedTip != nil) {
                    navigateToConfirmation = true
                }
            }
            .padding(.top, 228)
            .sheet(isPresented: $showingCustomTipSheet) {
                CustomTipSheet(customTipInput: $customTipInput, onCancel: {
                    showingCustomTipSheet = false
                }, onDone: {
                    // Validate numeric percentage and set selectedTip
                    let trimmed = customTipInput.trimmingCharacters(in: .whitespacesAndNewlines)
                    if let value = Double(trimmed), value >= 0 {
                        selectedTip = "Custom: \(Int(value))%"
                        showingCustomTipSheet = false
                    }
                })
            }
        }
    }
}

struct TipButtonView: View {
    var text: String
    var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color(red: 0.4667, green: 0, blue: 1) : Color.clear, lineWidth: 2)
                )
                .frame(width: 107, height: 53)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            
            Text(text)
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(Color(red: 0.4667, green: 0, blue: 1))
                .frame(width: 73, height: 27)
                .multilineTextAlignment(.center)
        }
    }
}

struct ConfirmButtonView: View {
    var isEnabled: Bool = true
    var onConfirm: () -> Void = {}
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.4667, green: 0, blue: 1))
                .frame(width: 222, height: 43.37)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
            
            Text("Confirm")
                .font(.custom("Inter-SemiBold", size: 12))
                .foregroundColor(.white)
                .frame(width: 151.46, height: 22.1)
                .multilineTextAlignment(.center)
        }
        .opacity(isEnabled ? 1.0 : 0.5)
        .onTapGesture {
            if isEnabled {
                onConfirm()
            }
        }
    }
}

struct CustomTipSheet: View {
    @Binding var customTipInput: String
    var onCancel: () -> Void
    var onDone: () -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Enter custom tip (%)")
                    .font(.headline)
                TextField("e.g. 18", text: $customTipInput)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
                    .multilineTextAlignment(.center)
                HStack(spacing: 20) {
                    Button("Cancel") { onCancel() }
                        .foregroundColor(.red)
                    Button("Done") { onDone() }
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationTitle("Custom Tip")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TippingPassengerView()
}
