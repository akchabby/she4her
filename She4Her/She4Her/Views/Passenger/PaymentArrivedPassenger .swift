import SwiftUI

struct PayingPassengerView: View {
    var body: some View {
        VStack {
            Spacer()
            Group {
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "checkmark.square")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color(red: 0.197, green: 0.76, blue: 0.31))
                        Text("Arrived!")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(Color(red: 0.197, green: 0.76, blue: 0.31))
                    }
                    Text("Your Total")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                    Text("$17.30")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                }
                .frame(width: 236, height: 251)
                .background(Color.white)
                .cornerRadius(10)
                
                HStack(spacing: 22) {
                    NavigationLink(destination: TippingPassengerView()) {
                        Text("Split Bill")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(width: 107, height: 53)
                            .background(Color(red: 0.467, green: 0, blue: 1))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: TippingPassengerView()) {
                        Text("One Bill")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(width: 107, height: 53)
                            .background(Color(red: 0.467, green: 0, blue: 1))
                            .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    PayingPassengerView()
}

