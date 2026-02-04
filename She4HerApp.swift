//
//  She4HerApp.swift
//  She4Her
//
//  Created by Abby Chen on 11/9/25.
//

import SwiftUI

@main
struct She4HerApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView()
        }
    }
}

struct SplashView: View {
    @State private var isSignedIn = false

    var body: some View {
        if isSignedIn {
            ContentView()  // main Passenger/Driver UI
        } else {
            SignIn()
        }
    }
}
