//
//  CardView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-05.
//
import CachedAsyncImage
import SwiftUI

struct CardView: View {
    let frameHeight: CGFloat = 400
    let frameWidth: CGFloat = 280
    var cardImage = "Cards/fc24-gold-2"
    var flagImage = "Nations/19"
    var leagueImage = "Leagues/13"
    var clubImage = "Clubs/11"
    var player: Player
    var cardUrl = ""
    var textColour = Color(Color.gray)
    var needToDownloadCard = false
    var playerFaceUrl = ""
    
    init(player: Player) {
        self.player = player
        if let playerAlt = player.altimage {
            self.playerFaceUrl = ContentService.getPlayerFacesUrl() + playerAlt + ".png"
        } else {
            self.playerFaceUrl = ContentService.getPlayerFacesUrl() + player.pid + ".png"
        }
//        self.itemInfo = itemInfo
        self.cardImage = player.getCardName()
        self.clubImage = "Clubs/\(player.club)"
        self.leagueImage = "Leagues/\(player.league)"
        self.flagImage = "Nations/\(player.nation)"
        if self.cardImage == "" {
            self.needToDownloadCard = true
            self.cardUrl = ContentService.getCardImagesUrl() + player.rare + ".png"
        }
        self.textColour = Color.init(hexStr: self.player.itemInfo?.color ?? "453A22")
    }
    
    var body: some View {
        VStack {
            ZStack {
                if self.needToDownloadCard {
                    CachedAsyncImage(url: URL(string: self.cardUrl)!){
                        image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } 
                    placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(cardImage).resizable()
                }
                VStack{
                    HStack{
                        // MARK: - Player Overvall and Position
                        VStack{
                            Text(player.rating).font(.system(size: 37, weight: .bold)).foregroundStyle(self.textColour)
                            Text(player.position).font(.system(size: 18, weight: .semibold)).foregroundStyle(self.textColour).multilineTextAlignment(.leading)
                        }.position(x:63, y: 145).frame(alignment: .center)
                        
                        // MARK: - Player Face
                        AsyncImage(url: URL(string: playerFaceUrl)){
                            image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: self.frameWidth / 1.5).position(x: 20, y: 200)
                        
                    }.frame(width: self.frameWidth, height: self.frameHeight, alignment: .center)
                    
                    // MARK: - Player Name
                    Text(player.cardname).font(.system(size: 23, weight: .medium)).foregroundStyle(self.textColour).frame(maxWidth: self.frameWidth - 20).offset(y: -111)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    // MARK: - Player Six Attributes
                    HStack {
                        VStack{
                            Text(player.att1Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att1).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        VStack{
                            Text(player.att2Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att2).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        VStack{
                            Text(player.att3Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att3).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        VStack{
                            Text(player.att4Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att4).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        VStack{
                            Text(player.att5Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att5).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        VStack{
                            Text(player.att6Label).fontWeight(.medium).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text(player.att6).fontWeight(.bold).foregroundStyle(self.textColour).scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                    }.frame(maxWidth: self.frameWidth - 115, alignment: .center).offset(y:-110)
                    
                    // MARK: - Player Nationality, League and Club
                    HStack {
                        Image(flagImage).resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.frameWidth / 8.5)
                        Image(leagueImage).resizable().aspectRatio(contentMode: .fit)
                        Image(clubImage).resizable().aspectRatio(contentMode: .fit)
                    }.frame(width: self.frameWidth / 3, height: 35).position(x:self.frameWidth/2, y: -106)
                    
                }.frame(maxWidth: self.frameWidth, maxHeight: self.frameHeight, alignment: .center)
            }
        }.frame(width: self.frameWidth, height: self.frameHeight, alignment: .center)
    }
}

#Preview {
    CardView(player: Player())
}

