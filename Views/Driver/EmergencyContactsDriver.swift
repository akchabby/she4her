import SwiftUI

struct DriverContact: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var number: String
}

struct EmergencyContactsDriver: View {
    @State private var showingAddContact = false
    @State private var primaryContact = DriverContact(name: "Jessica Hedge", number: "717-347-5768")
    @State private var secondaryContacts: [DriverContact] = [
        DriverContact(name: "Keri Night", number: "678-346-2847"),
        DriverContact(name: "Nadia Dosco", number: "617-451-7621")
    ]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Primary Contact Card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Primary Contact")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                            Spacer()
                            Text("Primary")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(
                                    LinearGradient(
                                        colors: [Color(red: 0.467, green: 0, blue: 1), Color(red: 0.6, green: 0.2, blue: 1)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(6)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 12) {
                                Text("Name")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                                Text(primaryContact.name)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.primary.opacity(0.7))
                            }
                            HStack(spacing: 12) {
                                Text("Number")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                                Text(primaryContact.number)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.primary.opacity(0.7))
                            }
                        }

                        HStack {
                            Spacer()
                            Button(action: { /* edit primary */ }) {
                                Text("Edit")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            }
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal, 20)

                    // Secondary Contacts Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Secondary Contacts")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            ForEach(Array(secondaryContacts.enumerated()), id: \.element.id) { index, contact in
                                DriverContactRow(
                                    name: contact.name,
                                    number: contact.number,
                                    setPrimary: {
                                        // Swap selected secondary with primary
                                        let oldPrimary = primaryContact
                                        primaryContact = contact
                                        secondaryContacts[index] = oldPrimary
                                    }
                                )
                                if index != secondaryContacts.count - 1 {
                                    Divider().padding(.leading, 20)
                                }
                            }
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        )
                        .padding(.horizontal, 20)
                    }

                    // Add Contact Button
                    Button(action: { showingAddContact = true }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                            Text("Add Contact")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(
                                        LinearGradient(
                                            colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.6), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.6)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                        )
                        .padding(.horizontal, 20)
                    }
                    .buttonStyle(.plain)

                    Spacer(minLength: 0)
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .background(
                LinearGradient(
                    colors: [Color(UIColor.systemGroupedBackground), Color(UIColor.systemGroupedBackground).opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Emergency Contacts")
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddContact) {
                AddDriverContactView()
            }
        }
    }
}

struct DriverContactRow: View {
    let name: String
    let number: String
    var setPrimary: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.2), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 36, height: 36)
                Text(String(name.split(separator: " ").compactMap { $0.first }.prefix(2)))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text("Name")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary.opacity(0.7))
                }
                HStack(spacing: 8) {
                    Text("Number")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    Text(number)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.primary.opacity(0.7))
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                        .truncationMode(.tail)
                }
            }

            Spacer()

            Button(action: { setPrimary?() }) {
                HStack(spacing: 6) {
                    Image(systemName: "star.circle.fill")
                        .foregroundStyle(Color(red: 0.467, green: 0, blue: 1))
                        .font(.system(size: 16, weight: .semibold))
                    Text("Set as Primary")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.vertical, 6)
    }
}

struct AddDriverContactView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var number: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contact Information")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        // Name Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("Enter contact name", text: $name)
                                    .foregroundColor(.black)
                                    .textInputAutocapitalization(.words)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(name.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        // Phone Number Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                                    .frame(width: 20)
                                
                                TextField("(123) 456-7890", text: $number)
                                    .foregroundColor(.black)
                                    .keyboardType(.phonePad)
                            }
                            .padding()
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(number.isEmpty ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
                    )
                    
                    // Save Button
                    Button(action: {
                        // TODO: Save contact
                        dismiss()
                    }) {
                        Text("Save Contact")
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
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !number.isEmpty
    }
}

#Preview {
    EmergencyContactsDriver()
}
