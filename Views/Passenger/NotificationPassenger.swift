import SwiftUI

enum NotificationType {
    case arrival
    case cancellation
    case payment
    case safety
    case promotion
    case general
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let timestamp: Date
    var isRead: Bool = false
    
    var icon: String {
        switch type {
        case .arrival: return "car.fill"
        case .cancellation: return "xmark.circle.fill"
        case .payment: return "dollarsign.circle.fill"
        case .safety: return "shield.fill"
        case .promotion: return "star.fill"
        case .general: return "bell.fill"
        }
    }
    
    var iconColor: Color {
        switch type {
        case .arrival: return Color(red: 0.467, green: 0, blue: 1)
        case .cancellation: return .red
        case .payment: return .green
        case .safety: return .orange
        case .promotion: return Color(red: 0.467, green: 0, blue: 1)
        case .general: return .gray
        }
    }
}

struct NotificationPassenger: View {
    @Environment(\.dismiss) private var dismiss
    @State private var notifications: [NotificationItem] = [
        NotificationItem(
            type: .arrival,
            title: "Driver Arriving Soon",
            message: "Martha is 2 minutes away from your pickup location",
            timestamp: Date().addingTimeInterval(-300)
        ),
        NotificationItem(
            type: .payment,
            title: "Payment Successful",
            message: "Your payment of $23.50 has been processed",
            timestamp: Date().addingTimeInterval(-3600),
            isRead: true
        ),
        NotificationItem(
            type: .safety,
            title: "Safety Update",
            message: "Your emergency contact has been notified of your trip",
            timestamp: Date().addingTimeInterval(-7200),
            isRead: true
        ),
        NotificationItem(
            type: .cancellation,
            title: "Ride Cancelled",
            message: "Your scheduled ride for tomorrow has been cancelled",
            timestamp: Date().addingTimeInterval(-10800),
            isRead: true
        ),
        NotificationItem(
            type: .promotion,
            title: "Special Offer",
            message: "Get 20% off your next 3 rides this week!",
            timestamp: Date().addingTimeInterval(-86400),
            isRead: true
        ),
        NotificationItem(
            type: .general,
            title: "Welcome to She4Her",
            message: "Thank you for joining our community of safe riders",
            timestamp: Date().addingTimeInterval(-172800),
            isRead: true
        )
    ]
    @State private var showClearAlert = false
    @State private var navigateHome = false
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomePassenger(), isActive: $navigateHome) { EmptyView() }
            VStack(spacing: 0) {
                headerSection
                
                if notifications.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach($notifications) { $notification in
                                NotificationCard(notification: $notification)
                                    .onTapGesture {
                                        notification.isRead = true
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarBackButtonHidden(true)
        }
        .alert("Clear All Notifications", isPresented: $showClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear All", role: .destructive) {
                notifications.removeAll()
            }
        } message: {
            Text("Are you sure you want to clear all notifications?")
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    navigateHome = true
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
                
                Text("Notifications")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                if !notifications.isEmpty {
                    Button(action: {
                        showClearAlert = true
                    }) {
                        Text("Clear")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                    }
                } else {
                    Text("Clear")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.clear)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            
            if unreadCount > 0 {
                HStack {
                    Text("\(unreadCount) unread notification\(unreadCount == 1 ? "" : "s")")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        markAllAsRead()
                    }) {
                        Text("Mark all as read")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
            }
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "bell.slash.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 8) {
                Text("No Notifications")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("You're all caught up! New notifications will appear here")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Actions
    private func markAllAsRead() {
        for index in notifications.indices {
            notifications[index].isRead = true
        }
    }
}

// MARK: - Notification Card Component
struct NotificationCard: View {
    @Binding var notification: NotificationItem
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(notification.iconColor.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: notification.icon)
                    .font(.system(size: 22))
                    .foregroundColor(notification.iconColor)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(notification.title)
                        .font(.system(size: 15, weight: notification.isRead ? .medium : .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if !notification.isRead {
                        Circle()
                            .fill(Color(red: 0.467, green: 0, blue: 1))
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(notification.message)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text(timeAgoString(from: notification.timestamp))
                    .font(.system(size: 11))
                    .foregroundColor(.gray.opacity(0.7))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(notification.isRead ? Color.white : Color(red: 0.467, green: 0, blue: 1).opacity(0.03))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(notification.isRead ? Color.clear : Color(red: 0.467, green: 0, blue: 1).opacity(0.1), lineWidth: 1)
        )
    }
    
    private func timeAgoString(from date: Date) -> String {
        let seconds = Int(Date().timeIntervalSince(date))
        
        if seconds < 60 {
            return "Just now"
        } else if seconds < 3600 {
            let minutes = seconds / 60
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        } else if seconds < 86400 {
            let hours = seconds / 3600
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        } else {
            let days = seconds / 86400
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
    }
}

#Preview {
    NotificationPassenger()
}
