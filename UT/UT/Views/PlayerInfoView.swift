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
                //MARK: PlayStyles+
                VStack{
                    if displayedPlayer.stats?.playstylesPlus != nil && !(displayedPlayer.stats!.playstylesPlus!.isEmpty) {
                        VStack {
                            HStack{
                                Text("Playstyles+").font(.title2).bold().padding(.top, 5)
                                Spacer()
                            }
                            VStack {
                                ForEach(displayedPlayer.stats?.playstylesPlus?.split(separator: ",") ?? [], id:\.self) {
                                    playStylePlus in
                                    HStack{
                                        Text(playStylePlus)
                                        Spacer()
                                        Image("Playstyles/\(playStylePlus)-plus").resizable().scaledToFit().frame(width:40)
                                    }
                                }
                            }
                        }.padding(.bottom, 15)
                    }
                    VStack {
                        //MARK: PlayStyles
                        if displayedPlayer.stats?.playstyles != "" {
                            HStack{
                                Text("Playstyles").font(.title2).bold()
                                Spacer()
                            }
                            HStack {
                                ScrollView {
                                    ForEach(displayedPlayer.stats?.playstyles?.split(separator: ",") ?? [], id: \.self) { playStyle in
                                        VStack{
                                            HStack {
                                                Text(playStyle)
                                                Spacer()
                                                Image("Playstyles/\(playStyle)").resizable().scaledToFit().frame(width: 35)
                                            }
                                        }
                                    }
                                }
                            }
                        } else if displayedPlayer.stats?.playstylesPlus == nil || (displayedPlayer.stats!.playstylesPlus!.isEmpty){
                            HStack {
                                Text("Player has no playstyles")
                                Spacer()
                            }
                        }
                    }
                }
            }
        }.navigationTitle("\(displayedPlayer.cardname)")
            .onAppear(perform: {
                self.displayedPlayer = obtainedPlayer
                self.getData()
                self.getOtherVersions()
            })
            .refreshable {
                //                self.getLowestBin()
                //                self.getPlayerStatsAndPrice()
                self.getData()
                print("Swiped down to refresh in PlayerInfoView!")
            }
            .sheet(isPresented: $showCompare, content: {
                CompareView(basePlayer: $displayedPlayer)
            }
            )
        
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
                print("View Disappeared!", self.lastCheckedDate == nil ? "lastCheckedDate is nil" : "lastcheckeddate ISN'T nil")
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
            //            print("Price is", lb.bin!)
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
            DispatchQueue.main.async {
                self.otherVersions = otherVersions
                
                for p in self.otherVersions {
                    if p.lineid == self.obtainedPlayer.lineid {
                        p.lowestBin = self.obtainedPlayer.lowestBin
                        p.stats = self.obtainedPlayer.stats
                        break
                    }
                }
            }
            assignStatsAndPrice()
        })
    }
    
    private func assignStatsAndPrice(){
        if !self.otherVersions.isEmpty {
            self.otherVersions.forEach { p in
                ContentService.shared.getStatsAndLowestBin(for: p.lineid) { pStats, pLowBin in
                    DispatchQueue.main.async {
                        p.stats = pStats
                        p.lowestBin = pLowBin
                    }
                }
            }
        }
    }
    
}

#Preview {
    PlayerInfoView().environment(Player(withId: "19615"))
}
