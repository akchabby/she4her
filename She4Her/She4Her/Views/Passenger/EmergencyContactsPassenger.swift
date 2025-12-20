import SwiftUI

struct EmergencyContactsPassenger: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
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
            
            Text("Emergency Contacts")
                .font(.custom("Inter-Medium", size: 24))
                .padding(.horizontal, 32)
                .padding(.top, 91)
            
            Text("Primary")
                .font(.custom("Inter-SemiBold", size: 20))
                .padding(.horizontal, 32)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.custom("Inter-Medium", size: 16))
                        Text("Number")
                            .font(.custom("Inter-Medium", size: 16))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Jessica Hedge")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(.gray.opacity(0.44))
                        Text("717-347-5768")
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(.gray.opacity(0.44))
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Primary")
                                .font(.custom("Inter-Medium", size: 12))
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.black)
                                .cornerRadius(4)
                            
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 9, height: 9)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                
                                Text("?")
                                    .font(.custom("Inter-Regular", size: 9))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            
            Text("Secondary")
                .font(.custom("Inter-SemiBold", size: 20))
                .padding(.horizontal, 32)
                .padding(.top, 40)
            
            VStack(spacing: 20) {
                PassengerContactRow(name: "Keri Night", number: "678-346-2847")
                PassengerContactRow(name: "Nadia Dosco", number: "617-451-7621")
            }
            .padding(.horizontal, 32)
            .padding(.top, 20)
            
            Spacer()
        }
    }
}

struct PassengerContactRow: View {
    let name: String
    let number: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.custom("Inter-Medium", size: 16))
                Text("Number")
                    .font(.custom("Inter-Medium", size: 16))
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.gray.opacity(0.44))
                Text(number)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.gray.opacity(0.44))
            }
            
            Spacer()
            
            Text("Set as Primary")
                .font(.custom("Inter-Medium", size: 12))
                .foregroundColor(.purple)
        }
    }
}

#Preview {
    EmergencyContactsPassenger()
}
