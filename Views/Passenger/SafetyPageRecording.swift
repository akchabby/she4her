import SwiftUI
import MapKit

struct SafetyPageRecording: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var passengerCoordinate = CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090)
    @State private var driverCoordinate = CLLocationCoordinate2D(latitude: 37.3317, longitude: -122.0301)
    @State private var route: MKRoute?
    @State private var isRecording = false
    @State private var recordingDuration: TimeInterval = 0
    @State private var timer: Timer?
    @State private var showStopAlert = false
    
    var body: some View {
        ZStack {
            // Map Background
            Map(position: $cameraPosition) {
                Marker("Passenger", coordinate: passengerCoordinate)
                    .tint(Color(red: 0.467, green: 0, blue: 1))
                Marker("Driver", coordinate: driverCoordinate)
                    .tint(.blue)
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(Color(red: 0.467, green: 0, blue: 1), lineWidth: 4)
                }
            }
            .mapStyle(.standard)
            .edgesIgnoringSafeArea(.all)
            
            // Slight overlay
            Color.black.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                topBar
                Spacer()
                recordingSheet
            }
        }
        .onAppear {
            calculateRoute()
        }
        .alert("Stop Recording", isPresented: $showStopAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Stop", role: .destructive) {
                stopRecording()
            }
        } message: {
            Text("Are you sure you want to stop the recording?")
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            Button(action: {}) {
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
            
            VStack(spacing: 2) {
                Text("$43.23")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Text("Balance")
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
            
            Button(action: {}) {
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
        .padding(.top, 8)
        .offset(y: -2)
    }
    
    // MARK: - Recording Sheet
    private var recordingSheet: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            VStack(spacing: 24) {
                // Recording Status
                if isRecording {
                    recordingIndicator
                } else {
                    Text("Safety Recording")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Recording Controls
                VStack(spacing: 16) {
                    recordingControlCard
                    
                    if !isRecording {
                        additionalSafetyOptions
                    }
                }
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
    
    // MARK: - Recording Indicator
    private var recordingIndicator: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.2))
                    .frame(width: 16, height: 16)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
            }
            .opacity(isRecording ? 1 : 0)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isRecording)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Recording in Progress")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.red)
                
                Text(formatDuration(recordingDuration))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Recording Control Card
    private var recordingControlCard: some View {
        VStack(spacing: 20) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(isRecording ? Color.red.opacity(0.1) : Color(red: 0.467, green: 0, blue: 1).opacity(0.1))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: isRecording ? "stop.circle.fill" : "record.circle")
                        .font(.system(size: 50))
                        .foregroundColor(isRecording ? .red : Color(red: 0.467, green: 0, blue: 1))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(isRecording ? "Stop Recording" : "Start Recording")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(isRecording ? "Audio is being recorded for safety" : "Record your ride for added security")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Button(action: {
                if isRecording {
                    showStopAlert = true
                } else {
                    startRecording()
                }
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isRecording ? Color.red : Color(red: 0.467, green: 0, blue: 1))
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.98, green: 0.98, blue: 0.98))
        )
    }
    
    // MARK: - Additional Safety Options
    private var additionalSafetyOptions: some View {
        VStack(spacing: 12) {
            Text("Other Safety Options")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SafetyActionButton(
                icon: "phone.fill",
                title: "911 Speed Dial",
                subtitle: "Call emergency services",
                iconColor: .red,
                action: { }
            )
            
            SafetyActionButton(
                icon: "location.fill",
                title: "Share Location",
                subtitle: "Share with emergency contacts",
                iconColor: Color(red: 0.467, green: 0, blue: 1),
                action: { }
            )
        }
    }
    
    // MARK: - Actions
    private func startRecording() {
        isRecording = true
        recordingDuration = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            recordingDuration += 1
        }
    }
    
    private func stopRecording() {
        isRecording = false
        timer?.invalidate()
        timer = nil
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Helper
    private func calculateRoute() {
        let center = CLLocationCoordinate2D(
            latitude: (passengerCoordinate.latitude + driverCoordinate.latitude) / 2,
            longitude: (passengerCoordinate.longitude + driverCoordinate.longitude) / 2
        )
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        cameraPosition = .region(region)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: driverCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: passengerCoordinate))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
}

#Preview {
    SafetyPageRecording()
}
