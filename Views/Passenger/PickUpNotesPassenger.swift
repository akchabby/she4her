import SwiftUI

struct PickUpNotesPassenger: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pickupNotes = ""
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 24) {
                        instructionCard
                        notesInputSection
                        actionButtons
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Success!", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your feedback has been shared with the driver!")
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
            
            Text("Pickup Notes")
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
    
    // MARK: - Instruction Card
    private var instructionCard: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                
                Text("Share important notes with your driver!")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack(spacing: 10) {
                Image(systemName: "shield.checkered")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                
                Text("Driver may record audio for added safety")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
    
    // MARK: - Notes Input Section
    private var notesInputSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Notes")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Example: \"I'll be wearing a red jacket\" or \"Please use the back entrance\"")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
                
                ZStack(alignment: .topLeading) {
                    if pickupNotes.isEmpty {
                        Text("Enter your pickup notes here...")
                            .font(.system(size: 15))
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 20)
                    }
                    
                    TextEditor(text: $pickupNotes)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .frame(height: 150)
                        .padding(12)
                        .scrollContentBackground(.hidden)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(pickupNotes.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                submitNotes()
            }) {
                Text("Submit Notes")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(!pickupNotes.isEmpty ? Color(red: 0.467, green: 0, blue: 1) : Color.gray.opacity(0.5))
                            .shadow(color: !pickupNotes.isEmpty ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                    )
            }
            .disabled(pickupNotes.isEmpty)
            
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }
    
    // MARK: - Actions
    private func submitNotes() {
        print("Pickup notes: \(pickupNotes)")
        showSuccessAlert = true
    }
}

#Preview {
    PickUpNotesPassenger()
}
