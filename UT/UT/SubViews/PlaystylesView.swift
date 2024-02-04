//
//  PlaystylesView.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-04.
//

import SwiftUI

struct PlaystylesView: View {
    @Binding var playerStats: PlayerStats?
    
    var body: some View {
        //MARK: PlayStyles+
        VStack{
            if playerStats?.playstylesPlus != nil && !(playerStats!.playstylesPlus!.isEmpty) {
                VStack {
                    HStack{
                        Text("Playstyles+").font(.title3).bold().padding(.top, 5).foregroundColor(.secondary)
                        Spacer()
                    }
                    VStack {
                        ForEach(playerStats?.playstylesPlus?.split(separator: ",").sorted() ?? [], id:\.self) {
                            playStylePlus in
                            HStack{
                                Text(playStylePlus.capitalized)
                                Spacer()
                                Image("Playstyles/\(playStylePlus)-plus").resizable().scaledToFit().frame(width:40)
                            }
                        }
                    }
                }.padding(.bottom, 15)
            }
            VStack {
                //MARK: PlayStyles
                if playerStats?.playstyles != "" {
                    HStack{
                        Text("Playstyles").font(.title3).bold().foregroundStyle(.secondary)
                        Spacer()
                    }
                    HStack {
                        ScrollView {
                            ForEach(playerStats?.playstyles?.split(separator: ",").sorted() ?? [], id: \.self) { playStyle in
                                VStack{
                                    HStack {
                                        Text(playStyle.capitalized)
                                        Spacer()
                                        Image("Playstyles/\(playStyle)").resizable().scaledToFit().frame(width: 35)
                                    }
                                }
                            }
                        }
                    }
                } else if playerStats?.playstylesPlus == nil || (playerStats!.playstylesPlus!.isEmpty){
                    HStack {
                        Text("Player has no playstyles")
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    PlaystylesView(playerStats: .constant(Player(withId: "41").stats))
}
