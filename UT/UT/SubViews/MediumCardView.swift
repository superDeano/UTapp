//
//  MediumCardView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-11.
//

import SwiftUI
import CachedAsyncImage

struct MediumCardView: View {
    @EnvironmentObject var player: Player
    
    var body: some View {
        VStack{
            ZStack{
                //MARK: Card background
                CachedAsyncImage(url: URL(string: "\(player.itemInfo?.backgroundImage ?? (ContentService.getCardImagesUrl() + player.rare + ".png"))")) {
                    image in image.resizable()
                        .frame(width:180, height: 250)
                } placeholder: {
                    ProgressView()
                }
                
                //MARK: Player Face
                CachedAsyncImage(url: URL(string: "\(ContentService.getPlayerFacesUrl() + (player.altimage ?? player.pid)).png")) {
                    image in image.resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 125)
                        .offset(x: 10, y: -15)
                } placeholder: {
                    ProgressView()
                }
                //MARK: Card info
                VStack {
                        
                        //MARK: Player Rating and Position
                    HStack{
                        VStack {
                            Text(player.rating).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).bold().font(.system(size: 26))
                            Text(player.position).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).multilineTextAlignment(.leading).font(.system(size: 17, weight: .regular)).fontWidth(.condensed)
                        }.frame(alignment: .center)
                        Spacer()
                    }.padding(.leading, 25)
                        .offset(y: -25)
//                        .padding(.top, 10)
                    
                    //MARK: Player Name
                    HStack{
                        Text(player.cardname).foregroundStyle(Color.init(hexStr: player.itemInfo?.color ?? "453A22")).font(.system(size: 20)).fontWidth(.condensed)
                            .multilineTextAlignment(.center).frame(maxWidth: 140)
                    }.offset(y: 45)
                    
                    
                    //MARK: Nation, League, Team
                    HStack(alignment:.center) {
                        Spacer()
                        Image("Nations/\(player.nation)").resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24)
                        Spacer()
                        Image("Leagues/\(player.league)").resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24)
                        Spacer()
                        Image("Clubs/\(player.club)").resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24)
                        Spacer()
                    }.frame(maxWidth: 100, maxHeight: 20)
                        .offset(y: 35)
                        
                }
            }
        }.frame(width: 155, height: 250, alignment: .center).padding(.horizontal, 10)
    }
    
}

#Preview {
    Group {
        MediumCardView().environment(Player(withId: "19464"))
    }
}
