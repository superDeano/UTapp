//
//  PlayerInfoView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-03.
//

import SwiftUI

struct PlayerInfoView: View {
    public var player: Player
    var body: some View {
        List{
            Section(header: Text("Price")){
                VStack(){
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
            Section(header: Text("Biography")){
                VStack(){
                    HStack(){
                        Text("Name").bold()
                            .frame(maxWidth: 150, alignment: .leading)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.club)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("League").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.league)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack(){
                        Text("Nationality").bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(player.nation)
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
                    Text("Hello, World!")
                }
            }
            Section(header: Text("Playstyles")){
                VStack(){
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
        }.navigationTitle("\(player.cardname)")
            .refreshable {
                // TODO: get like newest price
            }
    }
}

#Preview {
    PlayerInfoView(player: Player())
}
