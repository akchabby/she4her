import SwiftUI

struct SettingsDriver: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Add some top padding to position higher
                    Spacer(minLength: 0)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white)
                            .frame(width: 308, height: 300)
                            .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 6)

                        VStack(spacing: 0) {
                            // Header
                            VStack(spacing: 4) {
                                Text("Settings")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color.purple)
                                Text("Manage your account and preferences")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 12)

                            Divider()
                                .padding(.horizontal, 16)

                            // Menu items (text-only)
                            VStack(spacing: 0) {
                                NavigationLink(destination: ProfileDriverView()) {
                                    ZStack {
                                        Text("Edit Profile")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color.purple)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        HStack { Spacer(); Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundColor(Color.purple) }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)

                                Divider().padding(.leading, 16)

                                NavigationLink(destination: EditingLicenseDriverView()) {
                                    ZStack {
                                        Text("Update License")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color.purple)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        HStack { Spacer(); Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundColor(Color.purple) }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)

                                Divider().padding(.leading, 16)

                                NavigationLink(destination: DeleteAccountDriverView()) {
                                    ZStack {
                                        Text("Delete Account")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color.purple)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        HStack { Spacer(); Image(systemName: "chevron.right").font(.system(size: 14, weight: .semibold)).foregroundColor(Color.purple) }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.top, 8)
                        }
                        .frame(width: 308, height: 240)
                    }
                    .padding(.top, 0)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    SettingsDriver()
}

