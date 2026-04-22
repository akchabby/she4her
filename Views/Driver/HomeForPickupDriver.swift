import SwiftUI
import MapKit

struct HomeForPickupDriver: View {
    @State private var rideInProgress = true
    @State private var pickupNotes = ""
    @State private var showCancelAlert = false
    @State private var showMenu = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ZStack {
            // Map Background
            Map(coordinateRegion: $region, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            // Route overlay
            VStack {
                Spacer()
                routeOverlay
                    .offset(y: -200)
            }
            
            // Top Bar
            VStack {
                topBar
                Spacer()
            }
            
            // Bottom Sheet
            VStack {
                Spacer()
                bottomSheet
            }
        }
        .alert("Cancel Ride", isPresented: $showCancelAlert) {
            Button("No, Keep Ride", role: .cancel) { }
            Button("Yes, Cancel", role: .destructive) {
                // Handle cancellation
            }
        } message: {
            Text("Are you sure you want to cancel this ride?")
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            // Notification Button
            Button(action: {
                // Show notifications
            }) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
            }
            
            Spacer()
            
            // Earnings Display
            VStack(spacing: 2) {
                Text("$205.12")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text("Today")
                    .font(.system(size: 11))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.6))
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            )
            
            Spacer()
            
            // Menu Button
            Button(action: {
                showMenu = true
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.6))
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .offset(y: -10)
    }
    
    // MARK: - Route Overlay
    private var routeOverlay: some View {
        ZStack {
            // Route circle
            Circle()
                .stroke(Color(red: 0.467, green: 0, blue: 1).opacity(0.3), lineWidth: 3)
                .fill(Color(red: 0.467, green: 0, blue: 1).opacity(0.05))
                .frame(width: 280, height: 280)
            
            // Pickup marker
            VStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 36, height: 36)
                    )
                
                Text("Pickup")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(red: 0.467, green: 0, blue: 1))
                    )
            }
            .offset(x: -80, y: -30)
            
            // Driver/Car marker
            Image(systemName: "car.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color(red: 0.467, green: 0, blue: 1))
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                )
            
            // Destination marker
            VStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.green)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 36, height: 36)
                    )
                
                Text("Dropoff")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(.green)
                    )
            }
            .offset(x: 80, y: 40)
        }
    }
    
    // MARK: - Bottom Sheet
    private var bottomSheet: some View {
        VStack(spacing: 0) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 20) {
                // Status Toggle
                rideStatusToggle
                
                // Destination Info
                destinationInfo
                
                // Passenger Info Card
                passengerInfoCard
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -4)
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Ride Status Toggle
    private var rideStatusToggle: some View {
        HStack {
            HStack(spacing: 12) {
                Text("Ride In Progress")
                    .font(.system(size: 13, weight: rideInProgress ? .bold : .medium))
                    .foregroundColor(rideInProgress ? .red : .gray)
                
                // Custom Toggle
                ZStack {
                    Capsule()
                        .fill(rideInProgress ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                        .frame(width: 50, height: 28)
                    
                    Circle()
                        .fill(rideInProgress ? Color.red : Color.green)
                        .frame(width: 22, height: 22)
                        .offset(x: rideInProgress ? -12 : 12)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        rideInProgress.toggle()
                    }
                }
                
                Text("Ride Complete")
                    .font(.system(size: 13, weight: !rideInProgress ? .bold : .medium))
                    .foregroundColor(!rideInProgress ? .green : .gray)
            }
            
            Spacer()
            
            // Online Badge
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Online")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.green)
            }
        }
    }
    
    // MARK: - Destination Info
    private var destinationInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Pickup Location")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text("345 Iron Rock Jut Ave")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("ETA")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    Text("10 min")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
    
    // MARK: - Passenger Info Card
    private var passengerInfoCard: some View {
        VStack(spacing: 16) {
            // Passenger Header
            HStack(spacing: 12) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.467, green: 0, blue: 1).opacity(0.2), Color(red: 0.6, green: 0.2, blue: 1).opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                
                // Passenger Details
                VStack(alignment: .leading, spacing: 4) {
                    Text("Jessie Stone")
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
                        Text("12 trips")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Safety Button
                Button(action: {
                    // Show safety options
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                        Text("Safety")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.1))
                    )
                }
            }
            
            // Pickup Notes & Cancel
            HStack(spacing: 12) {
                // Notes TextField
                HStack {
                    Image(systemName: "note.text")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    TextField("Any pickup notes?", text: $pickupNotes)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                )
                
                // Cancel Ride Button
                Button(action: {
                    showCancelAlert = true
                }) {
                    Text("Cancel")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    HomeForPickupDriver()
}

