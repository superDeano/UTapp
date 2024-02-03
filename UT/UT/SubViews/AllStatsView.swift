//
//  AllStatsView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-05.
//

import SwiftUI

struct AllStatsView: View {
    @Binding var stats: PlayerStats?
    @State private var statsExpanded = false
    private let paddingTop: CGFloat = 2
    private let paddingBottom: CGFloat =  15
    
    
    var body: some View {
        VStack {
            VStack {
                Button {
                    self.statsExpanded.toggle()
                } label: {
                    HStack {
                        Text(statsExpanded ? "Collapse" : "Expand").font(.body).fontWeight(.light)
                        Spacer()
                        Image(systemName: statsExpanded ? "arrow.up.right.and.arrow.down.left.square.fill" : "arrow.down.backward.and.arrow.up.forward.square")
                            .resizable()
                            .scaledToFit()
                            .contentTransition(.symbolEffect(.replace))
                            .frame(width: 25)
                    }
                }
            }
            //MARK: - Pace
            VStack{
                HStack{
                    Text("Pace").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att1 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Acceleration")
                        Spacer()
                        Text(stats?.acceleration ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Sprint Speed")
                        Spacer()
                        Text(stats?.sprintspeed ?? "")
                    }
                    HStack{
                        Text("AcceleRATE").bold()
                        Spacer()
                        Text(stats?.accelerate ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Shooting
            VStack{
                HStack{
                    Text("Shooting").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att2 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Positioning")
                        Spacer()
                        Text(stats?.positioning ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Finishing")
                        Spacer()
                        Text(stats?.finishing ?? "")
                    }
                    HStack{
                        Text("Shot Power")
                        Spacer()
                        Text(stats?.shotpower ?? "")
                    }
                    HStack{
                        Text("Long Shots")
                        Spacer()
                        Text(stats?.longshot ?? "")
                    }
                    HStack{
                        Text("Volleys")
                        Spacer()
                        Text(stats?.volleys ?? "")
                    }
                    HStack{
                        Text("Penalties")
                        Spacer()
                        Text(stats?.penalties ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Passing
            VStack{
                HStack{
                    Text("Passing").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att3 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Vision")
                        Spacer()
                        Text(stats?.vision ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Crossing")
                        Spacer()
                        Text(stats?.crossing ?? "")
                    }
                    HStack{
                        Text("FK Accuracy")
                        Spacer()
                        Text(stats?.fkacc ?? "")
                    }
                    HStack{
                        Text("Short Passing")
                        Spacer()
                        Text(stats?.shortpass ?? "")
                    }
                    HStack{
                        Text("Long Passing")
                        Spacer()
                        Text(stats?.longpass ?? "")
                    }
                    HStack{
                        Text("Curve").fontWeight(.semibold)
                        Spacer()
                        Text(stats?.curve ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Dribbling
            VStack{
                HStack{
                    Text("Dribbling").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att4 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                
                if self.statsExpanded {
                    HStack{
                        Text("Agility")
                        Spacer()
                        Text(stats?.agility ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Balance")
                        Spacer()
                        Text(stats?.balance ?? "")
                    }
                    HStack{
                        Text("Reactions")
                        Spacer()
                        Text(stats?.reactions ?? "")
                    }
                    HStack{
                        Text("Ball Control")
                        Spacer()
                        Text(stats?.ballcontrol ?? "")
                    }
                    HStack{
                        Text("Dribbling")
                        Spacer()
                        Text(stats?.dribbling ?? "")
                    }
                    HStack{
                        Text("Composure")
                        Spacer()
                        Text(stats?.composure ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Defending
            VStack{
                HStack{
                    Text("Defending").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att5 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if statsExpanded {
                    HStack{
                        Text("Interception")
                        Spacer()
                        Text(stats?.tactaware ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Heading Accuracy")
                        Spacer()
                        Text(stats?.headingacc ?? "")
                    }
                    HStack{
                        Text("Defensive Awareness")
                        Spacer()
                        Text(stats?.marking ?? "")
                    }
                    HStack{
                        Text("Standing Tackle")
                        Spacer()
                        Text(stats?.standingtackle ?? "")
                    }
                    HStack{
                        Text("Sliding Tackle")
                        Spacer()
                        Text(stats?.slidetackle ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Physicality
            VStack{
                HStack{
                    Text("Physicality").bold().font(statsExpanded ? .title2 : .body)
                    Spacer()
                    Text(stats?.att6 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Jumbing")
                        Spacer()
                        Text(stats?.jumping ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Stamina")
                        Spacer()
                        Text(stats?.stamina ?? "")
                    }
                    HStack{
                        Text("Strength")
                        Spacer()
                        Text(stats?.strength ?? "")
                    }
                    HStack{
                        Text("Agression")
                        Spacer()
                        Text(stats?.aggression ?? "")
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    AllStatsView(stats: .constant(PlayerStats()))
}
