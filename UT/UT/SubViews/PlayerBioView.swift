//
//  PlayerBioView.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-02.
//

import SwiftUI

struct PlayerBioView: View {
    @Binding var player: Player
    private let maxWidth: CGFloat = 100
    private let maxImageWidth: CGFloat = 20
    private let dividerHeight: CGFloat = 20
    
    var body: some View {
        VStack(){
            HStack(){
                Text(player.name).font(.title2).bold().fontWidth(.condensed)
                Spacer()
                Text(player.getAltPositions()).font(.subheadline)
            }
            HStack(){
                Image(systemName: "app.gift")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: self.maxImageWidth + 3)
                    .foregroundColor(.gray)
                Text("\(player.dob) years")
                
                Spacer()
                Divider().frame(height: dividerHeight)
                Spacer()
                
                Image(systemName: "figure.dress.line.vertical.figure")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: self.maxImageWidth + 9)
                    .foregroundColor(.gray)
                Text("\(player.height) cm / \(player.heightft)")
                
                Spacer()
                Divider().frame(height: dividerHeight)
                Spacer()
                
                HStack(){
                    
                    Image(systemName: "shoeprints.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: self.maxImageWidth)
                        .foregroundColor(.gray)
                    Text(player.foot.uppercased())
                }
            }.font(.footnote).fontWeight(.light)
                .offset(x: 0, y: -10)
            
            Divider()
            
            HStack(){
                Text("Nationality").bold().foregroundStyle(Color.gray)
                    .frame(maxWidth: self.maxWidth, alignment: .leading)
                Text(Nations.nations[self.player.nation] ?? "")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Image("Nations/\(player.nation)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }.padding(.top, 5)
            
            HStack(){
                Text("Club").bold().foregroundStyle(Color.gray)
                Spacer()
                Text(Clubs.teams[self.player.club] ?? "")
                Image("Clubs/\(player.club)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }
            HStack(){
                Text("League").bold().foregroundStyle(Color.gray)
                Spacer()
                Text(Leagues.leagues[self.player.league] ?? "")
                Image("Leagues/\(player.league)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }
            
            Divider()
            
            HStack(){
                Text("Skill Moves").bold().foregroundStyle(Color.gray)
                    Spacer()
                HStack(){
                    Text(player.skillmoves)
                    Image(systemName: "star")
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .foregroundColor(.gray)

                }
            }.padding(.top, 5)
            HStack(){
                Text("Weak Foot").bold().foregroundStyle(Color.gray)
                    Spacer()
                HStack(){
                    Text(player.weakfoot)
                    Image(systemName: "star")
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            HStack(){
                Text("Attacking Workrate").bold().foregroundStyle(Color.gray)
                Spacer()
                Text(player.attackworkrate.uppercased())
                   
            }.padding(.top, 5)
            HStack(){
                Text("Defending Workrate").bold().foregroundStyle(Color.gray)
                    Spacer()
                Text(player.defenseworkrate.uppercased())
                   
            }.padding(.bottom, 5)
        }.padding(.top, 5)
    }
}

#Preview {
    PlayerBioView(player: .constant(Player(withId: "41")))
}
