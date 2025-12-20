import SwiftUI

struct EmergencyContactsSetAsPrimaryDriver: View {
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
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.system(size: 16, weight: .medium))
                    Text("Number")
                        .font(.system(size: 16, weight: .medium))
                }
                
                VStack(alignment: .leading) {
                    Text("Keri Night")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray.opacity(0.7))
                    Text("678-346-2847")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray.opacity(0.7))
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 30)
            
            Text("Secondary")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 32)
                .padding(.top, 55)
            
            VStack(spacing: 20) {
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
                    
                    Text("Set as Primary")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                        Text("Number")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Nadia Dosco")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray.opacity(0.7))
                        Text("617-451-7621")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("Set as Primary")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple)
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    EmergencyContactsSetAsPrimaryDriver()
}
