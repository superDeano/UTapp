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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                        .environmentObject(launchScreenState)
                }
                
                if launchScreenState.state != .firstStep{
                    NavigationStack{
                        TabView(){
                            
                            ContentView()
                                .tabItem {
                                    Label("Home", systemImage: "house")
                                }.environmentObject(launchScreenState)
                            
                            SearchByFilterView()
                                .tabItem {
                                    Label("Search", systemImage: "text.magnifyingglass")
                                }
                            
                        }.opacity(launchScreenState.state != .finished ? 0 : 1)
                    }
                }
            }

        }
    }
    
    
}
