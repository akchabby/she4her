import SwiftUI

struct EditingPaymentMethod2Driver: View {
    @State private var cardNumber: String = ""
    @State private var nameOnCard: String = ""
    @State private var expirationDate: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    // Back navigation action
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                }
                .padding(.leading, 22)
                
                Spacer()
            }
            .padding(.top, 41)
            
            Text("New Visa")
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 66)
                .padding(.top, 20)
            
            Image("credit_card_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 257, height: 161)
                .cornerRadius(10)
                .padding(.leading, 64)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Card Number")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                
                TextField("Enter card number", text: $cardNumber)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.horizontal, 82)
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Name on card")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                
                TextField("Enter name", text: $nameOnCard)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.horizontal, 82)
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Expiration Date")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                
                TextField("MM/YY", text: $expirationDate)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.horizontal, 82)
            .padding(.top, 20)
            
            Button(action: {
                // Update action
            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 37)
                    .background(Color(red: 0.467, green: 0, blue: 1))
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.top, 40)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    EditingPaymentMethod2Driver()
}



