import SwiftUI

public struct MenuItemRow: View {
    let icon: String
    let title: String
    var iconColor: Color = .primary
    let destination: AnyView

    public var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
                    .frame(width: 40, height: 40, alignment: .center)

                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay(
                Divider()
                    .padding(.leading, 68)
                    .offset(y: 0.5),
                alignment: .bottom
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        VStack(spacing: 0) {
            MenuItemRow(
                icon: "person",
                title: "Profile",
                destination: AnyView(Text("Profile Destination").padding())
            )
            MenuItemRow(
                icon: "gearshape",
                title: "Settings",
                iconColor: .blue,
                destination: AnyView(Text("Settings Destination").padding())
            )
            MenuItemRow(
                icon: "bell",
                title: "Notifications",
                iconColor: .red,
                destination: AnyView(Text("Notifications Destination").padding())
            )
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Menu")
    }
}

