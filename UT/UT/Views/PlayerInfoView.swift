//
//  PlayerInfoView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import SwiftUI

struct PlayerInfoView: View {
    
    @EnvironmentObject public var obtainedPlayer: Player
    @State private var displayedPlayer: Player = Player()
    @State private var otherVersions: [Player] = []
    @State private var lastCheckedDate : Date? = nil
    @State private var showCompare = false
    
    var body: some View {
        List{
            //MARK: CARD VIEW
            Section{
                VStack {
                    HStack{
                        Spacer()
                        CardView(player: displayedPlayer)
                        Spacer()
                    }
                    if self.otherVersions.count > 1 {
                        ScrollView(.horizontal){
                            HStack {
                                ForEach(self.$otherVersions){
                                    $otherVersion in
                                    Button {
                                        displayedPlayer = otherVersion
                                    } label: {
                                        MiniCardView(player: otherVersion)
                                    }
                                }.frame(maxWidth: .infinity)
                            }.frame(height: 60).padding(.top, 10)
                        }.scrollClipDisabled()
                    }
                    
                }
                
            }.listRowBackground(Color.clear)
                .frame(maxWidth: .infinity)
            
            //MARK: Price Section
            Section(header: Text("Price")){
                VStack(){
                    HStack(){
                        Text("Lowest Price").bold()
                        Spacer()
                        Text(displayedPlayer.lowestBin?.bin ?? "n/a")
                        Image("Misc/coins").resizable().scaledToFit().frame(maxWidth: 18)
                    }
                    HStack(){
                        Text("Last Updated").font(.callout).bold()
                        Spacer()
                        Text("\(displayedPlayer.lowestBin?.ud ?? "n/a") \(displayedPlayer.lowestBin != nil && displayedPlayer.lowestBin!.ud != "Never" ? "ago" : "")")
                            .font(.callout)
                    }
                }
            }
            //MARK: BIO
            Section(header: Text("Biography")){
                PlayerBioView(player: $displayedPlayer)
            }
            //MARK: All Stats
            Section(header: Text("Stats")){
                VStack{
                    AllStatsView(stats: $displayedPlayer.stats)
                }
            }
            Section(header: Text("Playstyles")){
                PlaystylesView(playerStats: $displayedPlayer.stats)
            }
        }.navigationTitle("\(displayedPlayer.cardname)")
            .onAppear(perform: {
                self.displayedPlayer = obtainedPlayer
                self.getData()
                self.getOtherVersions()
            })
            .refreshable {
                self.getData()
                print("Swiped down to refresh in PlayerInfoView!")
            }
#if os(iOS)
            .sheet(isPresented: $showCompare, content: {
                CompareView(basePlayer: $displayedPlayer)
            })
#endif
            .toolbar {
#if os(macOS)
                Button("Refresh", action: getLowestBin).keyboardShortcut("R", modifiers: .command)
#endif
                ToolbarItem(placement: .automatic){
                    Button {
                        self.showCompare = true
                    } label: {
                        Text("Compare")
                        Image(systemName: "arrow.left.arrow.right.circle.fill")
                    }
                }
            }
        
            .onAppear(perform: getPlayerStatsAndPrice)
            .onDisappear {
                self.lastCheckedDate = nil
            }
            .onChange(of: displayedPlayer) { _, _ in
                if self.lastCheckedDate == nil {
                    getData()
                    lastCheckedDate = Date()
                } else if lastCheckedDate!.timeIntervalSinceNow > 5 {
                    getData()
                    lastCheckedDate = Date()
                }
                
            }
    }
    
    private func getData(){
        getLowestBin()
        if displayedPlayer.stats == nil {
            getPlayerStats()
        }
        DispatchQueue.main.async {
            let temp = displayedPlayer
            displayedPlayer = Player()
            displayedPlayer = temp
            
        }
    }
    
    private func getLowestBin(){
        ContentService.shared.getLowestBin(for: displayedPlayer.lineid, finished: { lb in
            DispatchQueue.main.async {
                displayedPlayer.lowestBin = lb
            }
        })
    }
    
    private func getPlayerStats() -> Void {
        ContentService.shared.getPlayerStats(for: displayedPlayer.lineid, finished: { ps in
            DispatchQueue.main.async {
                displayedPlayer.stats = ps
            }
        })
    }
    
    private func getPlayerStatsAndPrice() -> Void {
        ContentService.shared.getStatsAndLowestBin(for: displayedPlayer.lineid) { pStats, pLowBin in
            DispatchQueue.main.async {
                displayedPlayer.stats = pStats
                displayedPlayer.lowestBin = pLowBin
            }
        }
        getOtherVersions()
    }
    
    private func getOtherVersions() -> Void {
        ContentService.shared.getOtherVersions(for: obtainedPlayer.urlname, finished: { otherVersions in
            
            for p in otherVersions {
                if p.lineid == self.obtainedPlayer.lineid {
                    p.lowestBin = self.obtainedPlayer.lowestBin
                    p.stats = self.obtainedPlayer.stats
                } else {
                    ContentService.shared.getStatsAndLowestBin(for: p.lineid) { pStats, pLowBin in
                            p.stats = pStats
                            p.lowestBin = pLowBin
                    }
                }
            }
            DispatchQueue.main.async {
                self.otherVersions = otherVersions
            }
        })
    }
    

    
}

#Preview {
    PlayerInfoView().environment(Player(withId: "19615"))
}
