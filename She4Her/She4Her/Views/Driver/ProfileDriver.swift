import SwiftUI

struct ProfileDriverView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 41)
                
                Text("Profile")
                    .font(.system(size: 24, weight: .medium))
                    .padding(.horizontal, 34)
                    .padding(.top, 12)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                        Text("Jane Dot")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 106, height: 105)
                        .clipShape(Circle())
                }
                .padding(.horizontal, 34)
                .padding(.top, 51)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Plate")
                            .font(.system(size: 16, weight: .medium))
                        Text("Y45-MD6")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("See")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 34)
                .padding(.top, 34)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("License")
                            .font(.system(size: 16, weight: .medium))
                        Text("See")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.purple)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 34)
                .padding(.top, 31)
                
                Text("Vehicle")
                    .font(.system(size: 24, weight: .medium))
                    .padding(.horizontal, 34)
                    .padding(.top, 32)
                
                VStack(spacing: 16) {
                    HStack {
                        Text("Type")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Text("SUV")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Image("vehicle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 111)
                        .cornerRadius(8)
                    
                    HStack {
                        Text("Kids")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("Partners")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("Pets")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Toggle("", isOn: .constant(false))
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, 34)
                .padding(.top, 16)
                
                Button(action: {}) {
                    Text("Add New Vehicle")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 34)
                .padding(.top, 16)
                
                Button(action: {}) {
                    Text("Delete Vehicle")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 34)
                .padding(.top, 16)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Payment")
                        .font(.system(size: 24, weight: .medium))
                    
                    Text("Cards & Payments")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple)
                    
                    Text("Account Settings")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple)
                    
                    Text("Emergency Contacts")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple)
                }
                .padding(.horizontal, 34)
                .padding(.top, 32)
            }
        }
    }
}

#Preview {
    ProfileDriverView()
}
