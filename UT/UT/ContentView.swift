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
            // MARK: Search List View
            if presentSearch {
                List {
                    ForEach($searchedPlayers) {
                        $searchedPlayer in
                        NavigationLink {
                            PlayerInfoView(itemInfo: itemManager.getItemInfo(for: searchedPlayer.smallpreview)).environment(searchedPlayer)
                        } label: {
                            HStack {
                                Text(searchedPlayer.name)
                                Spacer()
                                HStack{
                                    MiniCardView(player: searchedPlayer, itemManager: itemManager)
                                }.frame(maxWidth: 40)
                            }
                        }
                    }
                }

            } else {
                // MARK: List of popular players view
                List {
                    Section(header: Text("Latest Players")) {
                        ForEach($latestPlayers) { $latestPlayer in
                            NavigationLink {
                                PlayerInfoView(itemInfo: itemManager.getItemInfo(for: latestPlayer.cardtype)).environment(latestPlayer)
                            } label: {
                                Text("\($latestPlayer.wrappedValue.name)")
                            }
                        }
                    }
                    Section(header: Text("Popular Players")) {
                        ForEach($popularPlayers) { $popPlayer in
                            NavigationLink {
                                PlayerInfoView(itemInfo: itemManager.getItemInfo(for: popPlayer.cardtype)).environment(popPlayer)
                            } label: {
                                Text("\(popPlayer.name)")
                            }
                        }
                    }
                }.onAppear(perform: getLatestAndPopularPlayers)
                    .refreshable {
                        getLatestAndPopularPlayers()
                    }
                //            }
#if os(macOS)
                
                    .navigationSplitViewColumnWidth(min: 160, ideal: 180)
                
                    .toolbar {
                        ToolbarItem {
                            Button(action: getLatestPlayers) {
                                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
                            }.keyboardShortcut(KeyboardShortcut("N", modifiers: [.shift, .command]))
                        }
                    }
#endif
            }
            } detail: {
                Text("Select an item")
            }.environmentObject(itemManager)
            .searchable(text: $searchText, prompt: "Player name").onChange(of: $searchText) {
                _, newValue in
                presentSearch = searchText.count > 0 ? true : false
                runSearch()
            }.onSubmit {
                runSearch()
            }
            .onChange(of: isSearching) {
                print("change of isSearching:", isSearching, "text is:", searchText)
            }
            
        
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
