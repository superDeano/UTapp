//
//  ContentView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-02.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var latestPlayers = [Player]()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            
            List {
                ForEach(latestPlayers) { latestPlayer in
                    NavigationLink {
                        PlayerInfoView(for: latestPlayer)
//                            .modelContainer(modelContext)
                    } label: {
                        Text("\(latestPlayer.name)")
                    }
                }
//                .onDelete(perform: deleteItems)
            }.onAppear(perform: getLatestPlayers)
                .refreshable {
                    getLatestPlayers()
                }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 160, ideal: 180)
#endif
            /*.toolbar {
                //#if os(iOS)
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    EditButton()
                //                }
                //#endif
                ToolbarItem {
                    Button(action: getLatestPlayers) {
                        Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
                    }
                }
            }*/
        } detail: {
            Text("Select an item")
        }
//        .task {
//            <#code#>
//        }
        .searchable(text: $searchText)
            .onSubmit() {
                runSearch()
            }
            .onChange(of: searchText) { runSearch() }
            
    }
    
    
    private func runSearch(){
        if (!searchText.isEmpty){
            print("Searching for \(searchText)")
        }
    }
    
    private func getLatestPlayers(){
        let service = ContentService()
        service.getLatestPlayers(finished: {
            players in latestPlayers = players
        })
//        print("After getting latestPlayers,",$latestPlayers.count)
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
