//
//  AllStatsView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-05.
//

import SwiftUI

struct AllStatsView: View {
//    var playerId: String
   @Binding var stats: PlayerStats
    
//    init(for playerId: String){
//        self.playerId = playerId
//        self.player = PlayerStats()
//    }
//    init(with playerStats: PlayerStats) {
//        player = playerStats
//    }
    
    var body: some View {
        VStack {
            VStack {
                //MARK: - Pace
                VStack{
                    HStack{
                        Text("Pace").bold().font(.title2)
                        Spacer()
                        Text(stats.att1 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Acceleration")
                        Spacer()
                        Text(stats.acceleration ?? "")
                    }
                    HStack{
                        Text("Sprint Speed")
                        Spacer()
                        Text(stats.sprintspeed ?? "")
                    }
                    HStack{
                        Text("AcceleRATE").bold()
                        Spacer()
                        Text(stats.accelerate ?? "")
                    }
                }.padding(.bottom, 15)
                
                //MARK: - Shooting
                VStack{
                    HStack{
                        Text("Shooting").bold().font(.title2)
                        Spacer()
                        Text(stats.att2 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Positioning")
                        Spacer()
                        Text(stats.positioning ?? "")
                    }
                    HStack{
                        Text("Finishing")
                        Spacer()
                        Text(stats.finishing ?? "")
                    }
                    HStack{
                        Text("Shot Power")
                        Spacer()
                        Text(stats.shotpower ?? "")
                    }
                    HStack{
                        Text("Long Shots")
                        Spacer()
                        Text(stats.longshot ?? "")
                    }
                    HStack{
                        Text("Volleys")
                        Spacer()
                        Text(stats.volleys ?? "")
                    }
                    HStack{
                        Text("Penalties")
                        Spacer()
                        Text(stats.penalties ?? "")
                    }
                }.padding(.bottom, 15)
                
                //MARK: - Passing
                VStack{
                    HStack{
                        Text("Passing").bold().font(.title2)
                        Spacer()
                        Text(stats.att3 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Vision")
                        Spacer()
                        Text(stats.vision ?? "")
                    }
                    HStack{
                        Text("Crossing")
                        Spacer()
                        Text(stats.crossing ?? "")
                    }
                    HStack{
                        Text("FK Accuracy")
                        Spacer()
                        Text(stats.fkacc ?? "")
                    }
                    HStack{
                        Text("Short Passing")
                        Spacer()
                        Text(stats.shortpass ?? "")
                    }
                    HStack{
                        Text("Long Passing")
                        Spacer()
                        Text(stats.longpass ?? "")
                    }
                    HStack{
                        Text("Curve").fontWeight(.semibold)
                        Spacer()
                        Text(stats.curve ?? "")
                    }
                }.padding(.bottom, 15)
                
                //MARK: - Dribbling
                VStack{
                    HStack{
                        Text("Dribbling").bold().font(.title2)
                        Spacer()
                        Text(stats.att4 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Agility")
                        Spacer()
                        Text(stats.agility ?? "")
                    }
                    HStack{
                        Text("Balance")
                        Spacer()
                        Text(stats.balance ?? "")
                    }
                    HStack{
                        Text("Reactions")
                        Spacer()
                        Text(stats.reactions ?? "")
                    }
                    HStack{
                        Text("Ball Control")
                        Spacer()
                        Text(stats.ballcontrol ?? "")
                    }
                    HStack{
                        Text("Dribbling")
                        Spacer()
                        Text(stats.dribbling ?? "")
                    }
                    HStack{
                        Text("Composure")
                        Spacer()
                        Text(stats.composure ?? "")
                    }
                }.padding(.bottom, 15)
                
                //MARK: - Defending
                VStack{
                    HStack{
                        Text("Defending").bold().font(.title2)
                        Spacer()
                        Text(stats.att5 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Interception")
                        Spacer()
                        Text(stats.tactaware ?? "")
                    }
                    HStack{
                        Text("Heading Accuracy")
                        Spacer()
                        Text(stats.headingacc ?? "")
                    }
                    HStack{
                        Text("Defensive Awareness")
                        Spacer()
                        Text(stats.marking ?? "")
                    }
                    HStack{
                        Text("Standing Tackle")
                        Spacer()
                        Text(stats.standingtackle ?? "")
                    }
                    HStack{
                        Text("Sliding Tackle")
                        Spacer()
                        Text(stats.slidetackle ?? "")
                    }
                }.padding(.bottom, 15)
                
                //MARK: - Physicality
                VStack{
                    HStack{
                        Text("Physicality").bold().font(.title2)
                        Spacer()
                        Text(stats.att6 ?? "").font(.title2)
                    }.padding(.bottom, 5)
                    HStack{
                        Text("Jumbing")
                        Spacer()
                        Text(stats.jumping ?? "")
                    }
                    HStack{
                        Text("Stamina")
                        Spacer()
                        Text(stats.stamina ?? "")
                    }
                    HStack{
                        Text("Strength")
                        Spacer()
                        Text(stats.strength ?? "")
                    }
                    HStack{
                        Text("Agression")
                        Spacer()
                        Text(stats.aggression ?? "")
                    }
                }
            }
        }
    }
    
}

#Preview {
//    struct FormView_View: PreviewProvider {
//        static var body: some View {
            AllStatsView(stats: .constant(PlayerStats()))
//        }
//    }
}
