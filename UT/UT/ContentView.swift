//
//  ContentView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-02.
//

import SwiftUI
import SwiftData



struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
    @State private var latestPlayers = [Player]()
    @State private var searchText: String = ""
    
    init() {
        getLatestPlayers()
    }
    
    
    var body: some View {
        NavigationSplitView {
            
            List {
                ForEach($latestPlayers) { $latestPlayer in
                    NavigationLink {
                        PlayerInfoView().environment(latestPlayer)
                    } label: {
                        Text("\($latestPlayer.wrappedValue.name)")
                    }
                }
            }//.onAppear(perform: getLatestPlayers)
                .refreshable {
                    getLatestPlayers()
                }.keyboardShortcut(KeyboardShortcut("N", modifiers: [.shift, .command]))
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 160, ideal: 180)

            .toolbar {
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
            }
#endif
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
        print("Getting latest players")
        let service = ContentService()
        service.getLatestPlayers(finished: {
            
            players in latestPlayers = players
//            latestPlayers.forEach { player in
//                service.getStatsAndLowestBin(for: player.lineid) { stats, lowBin in
//                    player.stats = stats
//                    player.lowestBin = lowBin
//                }
//            }
        })
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
