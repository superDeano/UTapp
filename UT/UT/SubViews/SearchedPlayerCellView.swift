//
//  SearchedPlayerCellView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-16.
//

import SwiftUI

struct SearchedPlayerCellView: View, Equatable {
    var player: Player
    var body: some View {
        
        HStack {
            VStack(alignment: .leading){
                Text(player.name).multilineTextAlignment(.leading)
                Text("\(Nations.nations[player.nation] ?? "") | \(Leagues.leagues[player.league] ?? "") | \(Clubs.teams[player.club] ?? "")").multilineTextAlignment(.leading).fontWidth(.compressed)
                
            }
            Spacer()
            HStack{
                MiniCardView(player: player)
            }.frame(maxWidth: 40)
        }
    }
    
    
    static func == (lhs: SearchedPlayerCellView, rhs: SearchedPlayerCellView) -> Bool {
        lhs.player.lineid == rhs.player.lineid // or whatever is equal
    }
}

#Preview {
    SearchedPlayerCellView(player: Player())
}
