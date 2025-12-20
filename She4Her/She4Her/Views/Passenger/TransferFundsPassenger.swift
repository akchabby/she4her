import SwiftUI

struct TransferFundsView: View {
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
                        .padding(12)
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
                        .padding(.leading, 31)
                        .padding(.top, 77)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.85))
                            .frame(width: 35, height: 44)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.96))
                            .frame(width: 96, height: 44)
                            .overlay(
                                Text("$")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                    .padding(.leading, 7)
                                    .padding(.top, 7)
                            )
                    }
                    .padding(.leading, 31)
                    .padding(.top, 29)
                    
                    Text("From")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 31)
                        .padding(.top, 64)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.96))
                            .frame(width: 178, height: 44)
                            .overlay(
                                Text("Choose Account")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .foregroundColor(Color.black.opacity(0.37))
                                    .padding(.leading, 7)
                                    .padding(.top, 7)
                            )
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.85))
                            .frame(width: 35, height: 44)
                            .overlay(
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 10, height: 6.17)
                                    .foregroundColor(Color.black.opacity(0.12))
                                    .padding(.leading, 5)
                                    .padding(.top, 6.67)
                            )
                    }
                    .padding(.leading, 31)
                    .padding(.top, 12)
                    
                    Text("To")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 31)
                        .padding(.top, 64)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.96))
                            .frame(width: 178, height: 44)
                            .overlay(
                                Text("Choose Account")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .foregroundColor(Color.black.opacity(0.37))
                                    .padding(.leading, 7)
                                    .padding(.top, 7)
                            )
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.85))
                            .frame(width: 35, height: 44)
                            .overlay(
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 10, height: 6.17)
                                    .foregroundColor(Color.black.opacity(0.12))
                                    .padding(.leading, 5)
                                    .padding(.top, 6.67)
                            )
                    }
                    .padding(.leading, 31)
                    .padding(.top, 12)
                }
                
                Spacer()
                
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: 88, height: 39)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        
                        Text("Confirm")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 32)
                    .padding(.bottom, 285)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TransferFundsView()
}

