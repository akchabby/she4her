import SwiftUI

enum DriverNotificationType {
    case rideRequest
    case rideComplete
    case payment
    case earnings
    case rating
    case cancellation
    case safety
    case promotion
    case general
}

struct DriverNotificationItem: Identifiable {
    let id = UUID()
    let type: DriverNotificationType
    let title: String
    let message: String
    let timestamp: Date
    var isRead: Bool = false
    
    var icon: String {
        switch type {
        case .rideRequest: return "car.circle.fill"
        case .rideComplete: return "checkmark.circle.fill"
        case .payment: return "dollarsign.circle.fill"
        case .earnings: return "banknote.fill"
        case .rating: return "star.fill"
        case .cancellation: return "xmark.circle.fill"
        case .safety: return "shield.fill"
        case .promotion: return "gift.fill"
        case .general: return "bell.fill"
        }
    }
    
    var iconColor: Color {
        switch type {
        case .rideRequest: return Color(red: 0.467, green: 0, blue: 1)
        case .rideComplete: return .green
        case .payment: return .green
        case .earnings: return Color(red: 0.467, green: 0, blue: 1)
        case .rating: return .orange
        case .cancellation: return .red
        case .safety: return .orange
        case .promotion: return Color(red: 0.467, green: 0, blue: 1)
        case .general: return .gray
        }
    }
}

struct NotificationDriver: View {
    @Environment(\.dismiss) private var dismiss
    @State private var notifications: [DriverNotificationItem] = [
        DriverNotificationItem(
            type: .rideRequest,
            title: "New Ride Request",
            message: "Passenger requested a ride 2.3 miles away - $18.50 fare",
            timestamp: Date().addingTimeInterval(-180)
        ),
        DriverNotificationItem(
            type: .rideComplete,
            title: "Ride Completed",
            message: "Trip to Downtown completed. Earnings: $23.50",
            timestamp: Date().addingTimeInterval(-1800),
            isRead: true
        ),
        DriverNotificationItem(
            type: .earnings,
            title: "Weekly Earnings Summary",
            message: "You earned $456.75 this week! That's 15% more than last week",
            timestamp: Date().addingTimeInterval(-3600),
            isRead: true
        ),
        DriverNotificationItem(
            type: .rating,
            title: "New 5-Star Rating",
            message: "Great job! Your passenger gave you 5 stars",
            timestamp: Date().addingTimeInterval(-7200),
            isRead: true
        ),
        DriverNotificationItem(
            type: .payment,
            title: "Payment Received",
            message: "Direct deposit of $389.50 has been processed to your account",
            timestamp: Date().addingTimeInterval(-10800),
            isRead: true
        ),
        DriverNotificationItem(
            type: .cancellation,
            title: "Ride Cancelled",
            message: "Passenger cancelled the ride. Cancellation fee applied",
            timestamp: Date().addingTimeInterval(-21600),
            isRead: true
        ),
        DriverNotificationItem(
            type: .safety,
            title: "Safety Update",
            message: "Emergency contact feature is now available in the app",
            timestamp: Date().addingTimeInterval(-43200),
            isRead: true
        ),
        DriverNotificationItem(
            type: .promotion,
            title: "Bonus Opportunity",
            message: "Complete 5 more rides today to earn a $50 bonus!",
            timestamp: Date().addingTimeInterval(-86400),
            isRead: true
        ),
        DriverNotificationItem(
            type: .general,
            title: "Welcome to She4Her",
            message: "Thank you for being part of our driver community",
            timestamp: Date().addingTimeInterval(-172800),
            isRead: true
        )
    ]
    @State private var showClearAlert = false
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerSection
                
                if notifications.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach($notifications) { $notification in
                                DriverNotificationCard(notification: $notification)
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

// MARK: - Driver Notification Card Component
struct DriverNotificationCard: View {
    @Binding var notification: DriverNotificationItem
    
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
    NotificationDriver()
}
