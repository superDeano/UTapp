//
//  UTApp.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-02.
//

import SwiftUI
import SwiftData

@main
struct UTApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Club.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                //            TabView(){
                ContentView()
                //                    .tabItem { Label("Home", systemImage: "house") }
                //            }
                if launchScreenState.state != .finished {
                    InstallView()
                }
            }.environment(launchScreenState)
        }
        .modelContainer(sharedModelContainer)
    }
    
    
}
