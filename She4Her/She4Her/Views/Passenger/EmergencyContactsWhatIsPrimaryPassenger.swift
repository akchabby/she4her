import SwiftUI

struct EmergencyContactsPrimary: View {
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
                .padding(.top, 32)
            
            Text("Primary")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 32)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                        Text("Number")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Jessica Hedge")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray.opacity(0.7))
                        Text("717-347-5768")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Primary")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            
            Text("Secondary")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 32)
                .padding(.top, 32)
            
            VStack(alignment: .leading, spacing: 16) {
                EmergencyContactRow(name: "Keri Night", number: "678-346-2847", isPrimary: false)
                EmergencyContactRow(name: "Nadia Dosco", number: "617-451-7621", isPrimary: false)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            
            Spacer()
        }
    }
}

struct EmergencyContactRow: View {
    let name: String
    let number: String
    let isPrimary: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.system(size: 16, weight: .medium))
                Text("Number")
                    .font(.system(size: 16, weight: .medium))
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray.opacity(0.7))
                Text(number)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray.opacity(0.7))
            }
            
            Spacer()
            
            Button("Set as Primary") {
                // Action
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.purple)
        }
    }
}

#Preview {
    EmergencyContactsPrimary()
}



