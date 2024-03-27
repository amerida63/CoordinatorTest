//
//  GPSCoordinatesApp.swift
//  GPSCoordinates
//
//  Created by Anthony merida on 27/3/24.
//

import SwiftUI

struct ParentTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("calculate")
                }
        }
    }
}

@main
struct GPSCoordinatesApp: App {
    var body: some Scene {
        WindowGroup {
            ParentTabView()
        }
    }
}
