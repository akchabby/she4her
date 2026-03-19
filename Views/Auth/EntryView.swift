import SwiftUI

struct EntryView: View {
    @AppStorage("hasCompletedInitialCredentials") private var hasCompletedInitialCredentials = false
    @AppStorage("userRole") private var userRole = ""
    @AppStorage("isSignedIn") private var isSignedIn = false
    
    var body: some View {
        NavigationStack {
            Group {
                if !isSignedIn {
                    // Show sign-in first
                    SignIn()
                } else {
                    // After sign-in, route based on credentials completion and role
                    if hasCompletedInitialCredentials {
                        if userRole == "driver" {
                            HomePageDriver()
                        } else {
                            HomePassenger()
                        }
                    } else {
                        SignUpPassenger()
                    }
                }
            }
        }
    }
}

#Preview {
    EntryView()
}


