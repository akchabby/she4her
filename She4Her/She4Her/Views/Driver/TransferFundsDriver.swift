import SwiftUI

struct TransferFundsDriver: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.black.opacity(0.12))
                        .padding(10)
                        .frame(width: 48, height: 48)
                    
                    Spacer()
                    
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 36, height: 24)
                        .foregroundColor(Color.black.opacity(0.12))
                        .padding(6)
                        .frame(width: 48, height: 48)
                }
                .padding(.horizontal, 22)
                .padding(.top, 41)
                
                Text("Transfer Your Funds")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .padding(.top, 94)
                    .padding(.leading, 32)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Amount")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 77)
                        .padding(.leading, 31)
                    
                    HStack(spacing: 0) {
                        ZStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: 35, height: 44)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            
                            Text("$")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 96, height: 44)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    }
                    .padding(.leading, 31)
                    .padding(.top, 29)
                    
                    Text("From")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 64)
                        .padding(.leading, 31)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 178, height: 44)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: 35, height: 44)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 10, height: 6.17)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 31)
                    .padding(.top, 16)
                    
                    Text("To")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 64)
                        .padding(.leading, 31)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 178, height: 44)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: 35, height: 44)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 10, height: 6.17)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 31)
                    .padding(.top, 16)
                    
                    HStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: 96, height: 38)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            
                            Text("Confirm")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 32)
                        .padding(.top, 65)
                    }
                }
            }
        }
    }
}

#Preview {
    TransferFundsDriver()
}

