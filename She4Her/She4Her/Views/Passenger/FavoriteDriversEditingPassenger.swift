import SwiftUI

struct FavoriteDriversEditingPassenger: View {
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
            
            Text("Favorites")
                .font(.system(size: 24, weight: .medium))
                .padding(.horizontal, 32)
                .padding(.top, 32)
            
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            Text("Name")
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("Nona Carlson")
                                .font(.system(size: 16, weight: .medium))
                                .opacity(0.44)
                        }
                        
                        HStack {
                            Text("Name")
                                .font(.system(size: 16, weight: .medium))
                            
                            Text("Justine Appleton")
                                .font(.system(size: 16, weight: .medium))
                                .opacity(0.44)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 18) {
                        Text("Delete")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                        
                        Text("Delete")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 0.467, green: 0, blue: 1))
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 18)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    FavoriteDriversEditingPassenger()
}
