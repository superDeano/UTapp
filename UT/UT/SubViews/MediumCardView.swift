//
//  MediumCardView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-11.
//

import SwiftUI

struct MediumCardView: View {
    @EnvironmentObject var player: Player
    
    var body: some View {
        VStack{
            ZStack{
                //MARK: Card background
                AsyncImage(url: URL(string: "\(player.itemInfo?.backgroundImage ?? (ContentService.getCardImagesUrl() + player.rare + ".png"))")) {
                    image in image.resizable()
                        .frame(width:180, height: 250)
                } placeholder: {
                    ProgressView()
                }
                
                //MARK: Card info
                VStack {

                        //MARK: Player Face
                        AsyncImage(url: URL(string: "\(ContentService.getPlayerFacesUrl() + (player.altimage ?? player.pid)).png")) {
                            image in image.resizable().aspectRatio(contentMode: .fill).frame(width: 125)
                        } placeholder: {
                            ProgressView()
                        }
                            .position(x: 100, y: 100)
                        
                        //MARK: Player Rating and Position
                        VStack {
                            Text(player.rating).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).bold().font(.system(size: 26))
                            Text(player.position).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).multilineTextAlignment(.leading).font(.system(size: 20, weight: .regular)).fontWidth(.condensed)
                        }.frame(alignment: .center).position(x: 42, y: 13)
                    
                    //MARK: Player Name
                    HStack{
                        
                        Text(player.cardname).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).font(.system(size: 20)).fontWidth(.condensed)
                            .multilineTextAlignment(.center)
                        
                    }.position(x: 175/2,y:55)
                    //MARK: Nation, League, Team
                    HStack {
                        
                        Image("Nations/\(player.nation)").resizable().aspectRatio(contentMode: .fit).frame(width: 24)
                        Image("Leagues/\(player.league)").resizable().aspectRatio(contentMode: .fit).frame(width: 24)
                        Image("Clubs/\(player.club)").resizable().aspectRatio(contentMode: .fit).frame(width: 24)
                    }.frame(maxWidth: 24, maxHeight: 20).position(x:175/2, y: 13)
                }
            }
        }.frame(width: 155, height: 250, alignment: .center).padding(.horizontal, 5)
    }
    
}

#Preview {
    Group {
        MediumCardView().environment(Player(for: "19464"))
    }
}
