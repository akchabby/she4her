import SwiftUI

struct SafetyPageDriver: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 36, height: 24)
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.trailing, 20)
                }
                .padding(.top, 40)
                
                Text("$43.23")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(white: 0.96))
                        .frame(width: 259, height: 43)
                    
                    HStack {
                        Text("Where to go?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.44))
                            .padding(.leading, 14)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(white: 0.11))
                            .padding(.trailing, 14)
                    }
                }
                .padding(.top, 20)
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 393, height: 305)
                        .cornerRadius(54)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.white)
                            }
                            
                            Text("911 Speed Dial")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(white: 0.12))
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "record.circle")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Record")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 48)
                                
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .frame(width: 26, height: 25)
                                    .foregroundColor(.white)
                            }
                            
                            Text("Share Location")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SafetyPageDriver()
}


