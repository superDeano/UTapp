//
//  CardView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-05.
//

import SwiftUI

struct CardView: View {
    let frameHeight: CGFloat = 400
    let frameWidth: CGFloat = 290
    var cardImage = "Cards/fc24-gold-2"
    var flagImage = "Nations/19"
    var leagueImage = "Leagues/13"
    var clubImage = "Clubs/11"
    var player: Player
    var playerPosition = "CM"
    var playerName = "Endo"
    var playerOverall = "80"
    
    
    
    var body: some View {
        VStack {
            ZStack {
                Image(cardImage).resizable()
                VStack{
                    HStack{
                        // MARK: - Player Overvall and Position
                        VStack{
                            Text(playerOverall).font(.system(size: 43, weight: .bold)).foregroundStyle(.regularMaterial)
                            Text(playerPosition).font(.system(size: 22, weight: .semibold)).foregroundStyle(.regularMaterial)
                        }.position(x:65, y: 150).frame(alignment: .center)
                        
                        // MARK: - Player Face
                        AsyncImage(url: URL(string: "https://cdn.futwiz.com/assets/img/fc24/faces/232487.png")){
                            image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }.frame(minWidth: self.frameWidth - 100).position(x: 20, y: 205)
                        
                    }.frame(width: self.frameWidth, height: self.frameHeight, alignment: .center)
                    
                    // MARK: - Player Name
                    Text(playerName).font(.system(size: 30, weight: .semibold)).foregroundStyle(.regularMaterial).offset(y: -110)
                    
                    // MARK: - Player Six Attributes
                    HStack {
                        VStack{
                            Text("PAC").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                        VStack{
                            Text("SHO").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                        VStack{
                            Text("PAS").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                        VStack{
                            Text("DRI").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                        VStack{
                            Text("DEF").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                        VStack{
                            Text("PHY").fontWeight(.medium).foregroundStyle(.regularMaterial)
                            Text(playerOverall).fontWeight(.bold).foregroundStyle(.regularMaterial)
                        }
                    }.frame(maxWidth: self.frameWidth - 50, alignment: .center).offset(y:-100)
                    
                    // MARK: - Player Nationality, League and Club
                    HStack {
                        Image(flagImage).resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.frameWidth/8.5)
                        Image(leagueImage).resizable().aspectRatio(contentMode: .fit)
                        Image(clubImage).resizable().aspectRatio(contentMode: .fit)
                    }.frame(width: self.frameWidth / 2, height: 35).position(x:self.frameWidth/2, y: -100)
                    
                }.frame(maxWidth: self.frameWidth, maxHeight: self.frameHeight, alignment: .center)
            }
        }.frame(width: self.frameWidth, height: self.frameHeight, alignment: .center)
    }
}

#Preview {
    CardView(player: Player())
}
