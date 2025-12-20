import SwiftUI

struct EmergencyContactsWhatIsPrimaryDriver: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                .frame(width: 48, height: 48)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                }
                .frame(width: 48, height: 48)
            }
            .padding(.horizontal, 22)
            .padding(.top, 41)
            
            Text("Emergency Contacts")
                .font(.system(size: 24, weight: .medium))
                .padding(.horizontal, 32)
                .padding(.top, 91)
            
            Text("Primary")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 32)
                .padding(.top, 25)
            
            VStack(alignment: .leading, spacing: 0) {
                EmergencyContactRowDriver(name: "Jessica Hedge", number: "717-347-5768", isPrimary: true)
                    .padding(.horizontal, 32)
            }
            .padding(.top, 16)
            
            Text("Secondary")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 32)
                .padding(.top, 50)
            
            VStack(spacing: 16) {
                EmergencyContactRowDriver(name: "Keri Night", number: "678-346-2847", isPrimary: false)
                EmergencyContactRowDriver(name: "Nadia Dosco", number: "617-451-7621", isPrimary: false)
            }
            .padding(.top, 16)
            
            Spacer()
        }
    }
}

struct EmergencyContactRowDriver: View {
    let name: String
    let number: String
    let isPrimary: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Name")
                    .font(.system(size: 16, weight: .medium))
                Text("Number")
                    .font(.system(size: 16, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black.opacity(0.37))
                Text(number)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black.opacity(0.37))
            }
            
            Spacer()
            
            if isPrimary {
                Text("Primary")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black)
                    .cornerRadius(8)
            } else {
                Text("Set as Primary")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple)
            }
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    EmergencyContactsWhatIsPrimaryDriver()
}

