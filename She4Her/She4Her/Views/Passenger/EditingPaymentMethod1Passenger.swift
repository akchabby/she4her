import SwiftUI

struct EditingPaymentMethod1Passenger: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.top, 41)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("My Card")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                
                ZStack {
                    Image("creditCardBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 257, height: 161)
                        .clipped()
                        .cornerRadius(16)

                    Image("CreditCard1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 245, height: 149)
                        .cornerRadius(14)
                }
                .padding(.top, 4)
                .padding(.horizontal, 64)
                
                Text("Add New")
                    .font(.custom("Inter-Bold", size: 18))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.leading, 20)

                Text("Visa")
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    .padding(.top, 12)
                    .padding(.leading, 23)
                
                HStack {
                    Spacer()
                    Text("Delete")
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                }
                .padding(.top, -80)
                .padding(.horizontal, 32)
            }
            .frame(width: 350, height: 420, alignment: .topLeading)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(red: 0.851, green: 0.851, blue: 0.851), lineWidth: 2)
            )
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    EditingPaymentMethod1Passenger()
}

