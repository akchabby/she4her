import SwiftUI

struct MenuIconDriver: View {
    var body: some View {
        NavigationLink(destination: MenuDriver()) {
            VStack {
                Spacer()
                
                VStack(spacing: 4) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 36, height: 4)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 36, height: 4)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 36, height: 4)
                }
                .frame(width: 36, height: 24)
                
                Spacer()
            }
            .frame(width: 48, height: 48)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    // For preview purposes
    NavigationStack {
        MenuIconDriver()
    }
}
