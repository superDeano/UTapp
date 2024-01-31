//
//  PlayerInfoView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import SwiftUI

struct PlayerInfoView: View {

    @EnvironmentObject public var obtainedPlayer: Player
    @State private var displayedPlayer = Player()
    @State private var otherVersions: [Player] = []
    private let maxWidth: CGFloat = 100
//    private var itemInfo: ItemInfo?
  
//    init(itemInfo: ItemInfo?){
//        self.itemInfo = itemInfo
//        self.displayedPlayer = player
//    }
    
    
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
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(self.otherVersions){
                                otherVersion in
                                Button {
                                    self.displayedPlayer = otherVersion
                                } label: {
                                    MiniCardView(player: otherVersion)
                                }
                            }
                        }
                    }.frame(height: 60)
                }
            }.listRowBackground(Color.clear)
                
//                .onChange(of: obtainedPlayer) {
//                    self.displayedPlayer = obtainedPlayer
//                    self.getData()
//                }
            
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
                VStack(){
                    HStack(){
                        Text("Name").bold()
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(displayedPlayer.name)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Age").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(displayedPlayer.dob)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Height").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(displayedPlayer.height) cm / \(displayedPlayer.heightft)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    //                    HStack(){
                    //                        Text("Weight").bold()
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //                        Text(player.)
                    //                            .frame(maxWidth: .infinity, alignment: .trailing)
                    //                    }
                    HStack(){
                        Text("Club").bold()
                        Spacer()
                        Text(Clubs.teams[self.displayedPlayer.club] ?? "")
                    }
                    HStack(){
                        Text("League").bold()
                        Spacer()
                        Text(Leagues.leagues[self.displayedPlayer.league] ?? "")
                    }
                    HStack(){
                        Text("Nationality").bold()
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(Nations.nations[self.displayedPlayer.nation] ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Skill Moves").bold()
                            Spacer()
                        HStack(){
                            Text(displayedPlayer.skillmoves)
                            Label("", systemImage: "star")
                                .labelStyle(.iconOnly)
                                .symbolVariant(.fill)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                    }
                    HStack(){
                        Text("Weak Foot").bold()
                            Spacer()
                        HStack(){
                            Text(displayedPlayer.weakfoot)
                            Label("", systemImage: "star")
                                .labelStyle(.iconOnly)
                                .symbolVariant(.fill)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                    }
                    HStack(){
                        Text("Preferred Foot").bold()
                            Spacer()
                        Text(displayedPlayer.foot)
                    }
                    HStack(){
                        Text("Attacking Workrate").bold()
                        Spacer()
                           Text(displayedPlayer.attackworkrate)
                           
                    }
                    HStack(){
                        Text("Defending Workrate").bold()
                            Spacer()
                        Text(displayedPlayer.defenseworkrate)
                           
                    }
                    HStack(){
                        Text("Alt Positions").bold()
                        Spacer()
                        Text(displayedPlayer.getAltPositions())
                    }
                }
            }
            Section(header: Text("Stats")){
                VStack(){
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
                self.getPlayerStatsAndPrice()
                print("Swiped down to refresh in PlayerInfoView!")
            }
#if os(macOS)
            .toolbar(content: {
                Button("Refresh", action: getLowestBin).keyboardShortcut("R", modifiers: .command)
            })
#endif
            .onAppear(perform: getPlayerStatsAndPrice)
            .onChange(of: displayedPlayer) { _, _ in
//#if os(macOS)
                getData()
//#else
//                if UIDevice.current.userInterfaceIdiom == .pad {
//                    getData()
//                }
//#endif
            }
    }
    
    private func getData(){
        getLowestBin()
        if displayedPlayer.stats == nil {
            getPlayerStats()
        }
    }
    
    private func getLowestBin(){
        ContentService.shared.getLowestBin(for: displayedPlayer.lineid, finished: { lb in
            DispatchQueue.main.async {
                displayedPlayer.lowestBin = lb
            }
            print("Price is", lb.bin!)
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
    }
    
    private func getOtherVersions() -> Void {
        ContentService.shared.searchPlayer(for: obtainedPlayer.urlname) { otherVersions in
            DispatchQueue.main.async {
                self.otherVersions = otherVersions
            }
        }
    }
}

#Preview {
    PlayerInfoView().environment(Player())
}
