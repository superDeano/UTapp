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
    private let maxImageWidth: CGFloat = 30
    
    var body: some View {
        VStack(){
            HStack(){
                Text("Name").bold()
//                    .frame(maxWidth: self.maxWidth, alignment: .leading)
                Spacer()
                Text(player.name)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
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
            HStack(){
                Text("Preferred Foot").bold()
                    Spacer()
                Text(player.foot.uppercased())
                Image(systemName: "shoeprints.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: self.maxImageWidth - 10)
                    .foregroundColor(.gray)
            }
            
            HStack(){
                Text("Club").bold()
                Spacer()
                Text(Clubs.teams[self.player.club] ?? "")
                Image("Clubs/\(player.club)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }.padding(.top, 5)
            HStack(){
                Text("League").bold()
                Spacer()
                Text(Leagues.leagues[self.player.league] ?? "")
                Image("Leagues/\(player.league)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }
            HStack(){
                Text("Nationality").bold()
                    .frame(maxWidth: self.maxWidth, alignment: .leading)
                Text(Nations.nations[self.player.nation] ?? "")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Image("Nations/\(player.nation)").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: self.maxImageWidth)
            }
            
            HStack(){
                Text("Skill Moves").bold()
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
                Text("Weak Foot").bold()
                    Spacer()
                HStack(){
                    Text(player.weakfoot)
                    Image(systemName: "star")
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .foregroundColor(.gray)
                }
            }
            
            HStack(){
                Text("Attacking Workrate").bold()
                Spacer()
                Text(player.attackworkrate.uppercased())
                   
            }.padding(.top, 5)
            HStack(){
                Text("Defending Workrate").bold()
                    Spacer()
                Text(player.defenseworkrate.uppercased())
                   
            }
            HStack(){
                Text("Alt Positions").bold()
                Spacer()
                Text(player.getAltPositions())
            }.padding(.top, 5)
        }
    }
}

#Preview {
    PlayerBioView(player: .constant(Player(withId: "41")))
}
