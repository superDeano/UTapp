//
//  ContentView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-02.
//

import SwiftUI
//import SwiftData



struct ContentView: View {
    //TODO: Read launchScreenManagerState to set state to finish only when data have been downloaded
    @State private var latestPlayers: [Player] = []
    @State private var searchText: String = ""
    @State private var searchedPlayers: [Player] = []
    @State private var popularPlayers: [Player] = []
    @State private var newestSbs: [SBC] = []
    @State private var presentSearch = false
    @State private var lastSearched: Date? = nil
    @Environment (\.isSearching) private var isSearching
    @EnvironmentObject private var launchStateManager: LaunchScreenStateManager
    
//    init() {
//        latestPlayers = []
//        searchedPlayers = []
//        popularPlayers = []
//        self.lastSearched = nil
//    }
    
    
    var body: some View {
        NavigationSplitView {
            
            // MARK: List of Latest players view
            List {
                Section(header: Text("Latest Players").bold().font(.title3)) {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach($latestPlayers) { $latestPlayer in
                                NavigationLink {
                                    PlayerInfoView().environment(latestPlayer)
                                    #if os(iOS)
                                        .toolbar(.hidden, for: .tabBar)
                                    #endif
                                } label: {
                                    MediumCardView().environment(latestPlayer)
                                }
                            }
                        }.frame(height: 250)
                    }.scrollClipDisabled()
                }.listRowBackground(Color.clear).listRowSeparator(.hidden).opacity(presentSearch ? 0 : 1)
                
                //MARK: List of Popular players
                Section(header: Text("Popular Players").bold().font(.title3)) {
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach($popularPlayers) { $popPlayer in
                                NavigationLink {
                                    PlayerInfoView().environment(popPlayer)
                                    #if os(iOS)
                                        .toolbar(.hidden, for: .tabBar)
                                    #endif
                                } label: {
                                    MediumCardView().environment(popPlayer)
                                }
                            }
                        }.frame(height: 250)
                    }.scrollClipDisabled()
                }.listRowBackground(Color.clear).listRowSeparator(.hidden).opacity(presentSearch ? 0 : 1)
                
                
                //MARK: Newest SBCs
                Section(header: Text("Newest SBCs").bold().font(.title3)) {
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(newestSbs, id: \.id) { sbc in
                                MediumSbcView(sbc: sbc)
                            }
                        }.frame(height: 250)
                    }.scrollClipDisabled()
                }.listRowBackground(Color.clear).listRowSeparator(.hidden).opacity(presentSearch ? 0 : 1)
                
            }
            // MARK: Search List View
            .overlay(content: {
                if presentSearch {
                    List {
                        ForEach($searchedPlayers) {
                            $searchedPlayer in
                            NavigationLink {
                                PlayerInfoView().environment(searchedPlayer)
                                #if os(iOS)
                                    .toolbar(.hidden, for: .tabBar)
                                #endif
                            } label: {
                                SearchedPlayerCellView(player: searchedPlayer)
                            }
                        }
                    }
                    
                }
            })
            .onAppear(perform:
                        {
                if self.latestPlayers.count == 0 {
                    self.getLatestPlayers()
                }
                if self.popularPlayers.count == 0 {
                    self.getPopularPlayers()
                    
                }
                if self.newestSbs.count == 0 {
                    self.getNewestSbcs()
                }
            }
            )
            .refreshable {
                getLatestAndPopularPlayers()
            }.listStyle(PlainListStyle())
                .navigationTitle(Text("Home"))
            
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
            //            }
        } detail: {
            Text("Select an item")
        }
        
        .searchable(text: $searchText, prompt: "Player name").onChange(of: $searchText) {
            _, newValue in
            presentSearch = searchText.count > 0 ? true : false
            if self.lastSearched == nil {
                runSearch()
                self.lastSearched = Date()
            } else if abs(self.lastSearched!.timeIntervalSinceNow) > 0.05 {
                runSearch()
                self.lastSearched = Date()
            }
        }.onSubmit(of: .search) {
            runSearch()
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
        getLatestPlayers()
        getPopularPlayers()
        getNewestSbcs()
    }
    
    func getLatestPlayers() -> Void {
        print("Getting latest players")
        ContentService.shared.getLatestPlayers(finished: { lPlayers in
            DispatchQueue.main.async {
                latestPlayers = lPlayers
            }
            
        })
    }
    
    func getPopularPlayers() -> Void {
        print("Getting Popular players")
        ContentService.shared.getPopularPlayers(finished: {
            players in
            DispatchQueue.main.async {
                popularPlayers = players
            }
        })
    }
    
    func getNewestSbcs() -> Void {
        print("Getting newest SBCs")
        ContentService.shared.getSbcs(onlyNew: true) { sbcs in
            DispatchQueue.main.async {
                self.newestSbs = sbcs
            }
        }
    }
    
}

#Preview {
    ContentView()
}

extension Binding<String>: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    
}
