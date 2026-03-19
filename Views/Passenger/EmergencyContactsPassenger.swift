import SwiftUI

struct Contact: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var number: String
}

struct EmergencyContactsPassenger: View {
    @State private var showingAddContact = false
    @State private var primaryContact = Contact(name: "Jessica Hedge", number: "717-347-5768")
    @State private var secondaryContacts: [Contact] = [
        Contact(name: "Keri Night", number: "678-346-2847"),
        Contact(name: "Nadia Dosco", number: "617-451-7621")
    ]

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
                                        colors: [Color.brandPurple, .pink],
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
                                    .foregroundColor(Color.brandPurple)
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
                                PassengerContactRow(
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
                                .foregroundColor(Color.brandPurple)
                            Text("Add Contact")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.brandPurple)
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
                                            colors: [Color.brandPurple.opacity(0.6), .pink.opacity(0.6)],
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Text("Emergency Contacts")
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddContact) {
                AddPassengerContactView()
            }
        }
    }
}

struct PassengerContactRow: View {
    let name: String
    let number: String
    var setPrimary: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.brandPurple.opacity(0.2), .pink.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 36, height: 36)
                Text(String(name.split(separator: " ").compactMap { $0.first }.prefix(2)))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.brandPurple)
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
                        .foregroundStyle(Color.brandPurple)
                        .font(.system(size: 16, weight: .semibold))
                    Text("Set as Primary")
                }
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.vertical, 6)
    }
}

struct AddPassengerContactView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var number: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $number)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // TODO: Persist the new contact and update the list
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EmergencyContactsPassenger()
}

