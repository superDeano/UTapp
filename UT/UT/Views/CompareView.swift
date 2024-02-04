//
//  CompareView.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-03.
//

import SwiftUI

struct CompareView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var basePlayer: Player
    @State private var presentSearch = false
    @State var comparedPlayers: [Player] = []
    @State private var searchedName: String = ""
    @State private var searchResults: [Player] = []
    @State private var downloading = false
    
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical]){
                LazyVStack(alignment: .leading) {
                    HStack(alignment: .top){
                        //MARK: Base Player
                        VStack(alignment: .center){
                            MediumCardView().environment(basePlayer)
                            PlayerBioView(player: $basePlayer)
                                .padding(.bottom, 5)
                            Divider()
                            AllStatsView(stats: $basePlayer.stats)
                                .padding(.trailing, 5)
                            Divider()
                            PlaystylesView(playerStats: $basePlayer.stats)
                        }
                        .padding(.bottom, 10)
                        .padding(.horizontal, 5)
                        .background(.quaternary)
                        .frame(width: 350)
                        
                        //MARK: Compared Players
                        ForEach(0..<self.comparedPlayers.count, id: \.self){
                            comparedPlayer in
                            VStack{
                                ZStack(alignment: .top) {
                                    HStack {
                                        Button {
                                            self.comparedPlayers.remove(at: comparedPlayer)
                                        } label: {
                                            Image(systemName: "clear.fill").resizable().scaledToFit()
                                                .frame(width: 30)
                                                .foregroundStyle(Color.red)
                                        }.position(x: 325, y: 35)
                                    }
                                    VStack{
                                        MediumCardView().environment(self.comparedPlayers[comparedPlayer])
                                            PlayerBioView(player: .constant(self.comparedPlayers[comparedPlayer]))
                                            .padding(.bottom, 5)
                                        Divider()
                                        AllStatsView(stats: .constant(self.comparedPlayers[comparedPlayer].stats))
                                        Divider()
                                        PlaystylesView(playerStats: .constant(self.comparedPlayers[comparedPlayer].stats))
                                    }.padding(.bottom, 10)
                                }
                            }
                            .frame(width: 350)
                            .padding(.horizontal, 10)
                            .background(.quinary)
                        }
                        
                    }.frame(alignment: .top)

                    
                }.padding(.horizontal, 15)
            }
            //MARK: Dialog to Search Player
            .sheet(isPresented: $presentSearch, content: {
                NavigationView {
                    List {
                        if downloading {
                            HStack {
                                Spacer()
                                ProgressView(label: {
                                    Text("Downloading")
                                })
                                Spacer()
                            }
                        } else {
                            ForEach(searchResults) {
                                p in
                                Button {
                                    self.comparedPlayers.append(p)
                                    self.presentSearch.toggle()
                                    self.searchedName.removeAll()
                                } label: {
                                    SearchedPlayerCellView(player: p).foregroundStyle(Color.secondary)
                                }
                            }
                        }
                    }.toolbar{
                        ToolbarItem(placement: .primaryAction, content: {
                            Button {
                                self.presentSearch.toggle()
                            } label: {
                                Text("Done")
                            }
                        })
                    }
                    .searchable(text: $searchedName, prompt: "Player name")
                        .onSubmit(of: .search) {
                            runSearch()
                        }
                    .navigationTitle("Search by Name")
                }
            })
            .defaultScrollAnchor(.topLeading)
            .scrollClipDisabled()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text("Cancel").foregroundStyle(Color.red)
                        }
                    }
                }
                
                //MARK: Adding button
                if self.comparedPlayers.count < 3 {
                    ToolbarItem(placement: .primaryAction){
                        Button {
                            self.presentSearch = true
                        } label: {
                            HStack {
                                Text("Add")
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Comparing \(basePlayer.cardname)")
        }
    }
    
    private func runSearch(){
        if (!searchedName.isEmpty && searchedName.count > 3){
            downloading = true
            ContentService.shared.searchPlayer(for: searchedName) { players in
                players.forEach { p in
                    ContentService.shared.getPlayerStats(for: p.lineid) { stats in
                        p.stats = stats
                    }
                }
                DispatchQueue.main.async {
                    searchResults = players
                    downloading = false
                }
            }
        }
    }
    
}

#Preview {
    CompareView(basePlayer: .constant(Player(withId: "41")))
}
