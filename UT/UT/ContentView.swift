//
//  ContentView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-02.
//

import SwiftUI
//import SwiftData



struct ContentView: View {
    @State private var latestPlayers: [Player]
    @State private var searchText: String = ""
    @State private var searchedPlayers: [Player]
    @State private var popularPlayers: [Player]
    @State private var presentSearch = false
    @Environment (\.isSearching) private var isSearching
//    @EnvironmentObject private var itemManager : GetItemInfo
    
    init() {
        self.latestPlayers = []
        self.searchedPlayers = []
        self.popularPlayers = []
    }
    
    
    var body: some View {
        NavigationSplitView {
            // MARK: Search List View
            if presentSearch {
                List {
                    ForEach($searchedPlayers) {
                        $searchedPlayer in
                        NavigationLink {
                            PlayerInfoView().environment(searchedPlayer)
                        } label: {
                            HStack {
                                Text(searchedPlayer.name)
                                Spacer()
                                HStack{
                                    MiniCardView(player: searchedPlayer)
                                }.frame(maxWidth: 40)
                            }
                        }
                    }
                }

            } else {
                // MARK: List of popular players view
                List {
                    Section(header: Text("Latest Players")) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach($latestPlayers) { $latestPlayer in
                                    NavigationLink {
                                        PlayerInfoView().environment(latestPlayer)
                                    } label: {
                                        HStack {
                                            MediumCardView().environment(latestPlayer)
                                        }.padding(.horizontal, 5)
                                    }
                                }
                            }.frame(height: 200, alignment: .top)
                        }
                    }.listRowBackground(Color.clear)
                    Section(header: Text("Popular Players")) {
                        ForEach($popularPlayers) { $popPlayer in
                            NavigationLink {
                                PlayerInfoView().environment(popPlayer)
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
            }//.environmentObject(itemManager)
            .navigationTitle(Text("Home"))
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
        if (!searchText.isEmpty && searchText.count > 3){
            print("Searching for \(searchText)")
            ContentService.shared.searchPlayer(for: searchText) { players in
                players.forEach { p in
                    DispatchQueue.main.async {
                        searchedPlayers = players
                    }
                }
            }
        }
    }
    
    private func getLatestAndPopularPlayers(){
        print("Getting latest players")
        ContentService.shared.getLatestPlayers(finished: { players in
            DispatchQueue.main.async {
                latestPlayers = players
            }

        })
        ContentService.shared.getPopularPlayers(finished: {
            players in
            DispatchQueue.main.async {
                popularPlayers = players
            }
        })
    }
}

#Preview {
    ContentView()//.environmentObject(GetItemInfo())
//        .modelContainer(for: Item.self, inMemory: true)
}

extension Binding<String>: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    
}
