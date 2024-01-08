//
//  PlayerInfoView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import SwiftUI
//import SwiftData

struct PlayerInfoView: View {
    //    @State public var playerStats: PlayerStats
    @EnvironmentObject public var player: Player
    //    @State private var lowestBin = LowestBin()
    //    @State private var playStyles = [String]()
    private let maxWidth: CGFloat = 100
    
    //        init(for player: Player){
    //            self.player = player
    //            playerStats = PlayerStats()
    //            self.getData()
    //        }
    
    
    var body: some View {
        List{
            Section{
                HStack{
                    Spacer()
                    CardView(player: player)
                    Spacer()
                }
            }.listRowBackground(Color.clear)
            
            Section(header: Text("Price")){
                VStack(){
                    HStack(){
                        Text("Lowest Price").bold()
                        Spacer()
                        Text(player.lowestBin?.bin ?? "n/a")
                        Image("Misc/coins").resizable().scaledToFit().frame(maxWidth: 18)
                    }
                    HStack(){
                        Text("Last Updated").font(.callout).bold()
                        Spacer()
                        Text("\(player.lowestBin?.ud ?? "n/a") \(player.lowestBin != nil && player.lowestBin!.ud != "Never" ? "ago" : "")")
                            .font(.callout)
                    }
                }
            }
            Section(header: Text("Biography")){
                VStack(){
                    HStack(){
                        Text("Name").bold()
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(player.name)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Age").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.dob)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Height").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(player.height) cm / \(player.heightft)")
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
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(Clubs.teams[self.player.club] ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("League").bold()
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(Leagues.leagues[self.player.league] ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Nationality").bold()
                            .frame(maxWidth: self.maxWidth, alignment: .leading)
                        Text(Nations.nations[self.player.nation] ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Skill Moves").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(){
                            Text(player.skillmoves)
                            Label("", systemImage: "star")
                                .labelStyle(.iconOnly)
                                .symbolVariant(.fill)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    HStack(){
                        Text("Weak Foot").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(){
                            Text(player.weakfoot)
                            Label("", systemImage: "star")
                                .labelStyle(.iconOnly)
                                .symbolVariant(.fill)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                    }
                    HStack(){
                        Text("Foot").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.foot)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Attacking Workrate").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.attackworkrate)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Defending Workrate").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.defenseworkrate)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                }
            }
            Section(header: Text("Stats")){
                VStack(){
                    AllStatsView(stats: $player.stats)
                }
            }
            Section(header: Text("Playstyles")){
                VStack{
                    if player.stats?.playstylesPlus != nil && !(player.stats!.playstylesPlus!.isEmpty) {
                        VStack {
                            HStack{
                                Text("Playstyles+").font(.title2).bold().padding(.top, 5)
                                Spacer()
                            }
                            HStack {
                                Text(player.stats?.playstylesPlus ?? "")
                                Spacer()
                                Image("Playstyles/\(player.stats!.playstylesPlus!)-plus").resizable().scaledToFit().frame(width:40)
                            }
                        }.padding(.bottom, 15)
                    }
                    VStack {
                        HStack{
                            Text("Playstyles").font(.title2).bold()
                            Spacer()
                        }
                        HStack {
                            ScrollView {
                                ForEach(player.stats?.playstyles?.split(separator: ",") ?? [], id: \.self) { playStyle in
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
                    }
                }
            }
        }.navigationTitle("\(player.cardname)")
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
            .onChange(of: player) { _, _ in
#if os(macOS)
                getData()
#else
                if UIDevice.current.userInterfaceIdiom == .pad {
                    getData()
                }
#endif
            }
        //            .onDisappear(perform: purgeCurrentPlayer)
        //            .task(priority: .high, {
        //                do {
        //                    getPlayerStats()
        //                    getLowestBin()
        //                } catch {
        //                    print(error)
        //                }
        //            })
    }
    
    private func getData(){
        getLowestBin()
        if player.stats == nil {
            getPlayerStats()
        }
    }
    
    private func getLowestBin(){
        ContentService().getLowestBin(for: player.lineid, finished: { lb in
            DispatchQueue.main.async {
                player.lowestBin = lb
            }
            print("Price is", lb.bin!)
        })
    }
    
    private func getPlayerStats() -> Void {
        let service = ContentService()
        service.getPlayerStats(for: player.lineid, finished: { ps in
            DispatchQueue.main.async {
                player.stats = ps
            }
        })
    }
    
    private func getPlayerStatsAndPrice() -> Void {
        let service = ContentService()
        service.getStatsAndLowestBin(for: player.lineid) { pStats, pLowBin in
            DispatchQueue.main.async {
                player.stats = pStats
                player.lowestBin = pLowBin
            }
        }
    }
    
    //    private func purgeCurrentPlayer(){
    //        self.player = Player()
    //    }
}

#Preview {
    PlayerInfoView().environment(Player())
}
