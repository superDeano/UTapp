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
                    Text("Pace").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att1 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Acceleration").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.acceleration ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Sprint Speed").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.sprintspeed ?? "")
                    }
                    HStack{
                        Text("AcceleRATE").bold().foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.accelerate ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Shooting
            VStack{
                HStack{
                    Text("Shooting").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att2 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Positioning").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.positioning ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Finishing").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.finishing ?? "")
                    }
                    HStack{
                        Text("Shot Power").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.shotpower ?? "")
                    }
                    HStack{
                        Text("Long Shots").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.longshot ?? "")
                    }
                    HStack{
                        Text("Volleys").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.volleys ?? "")
                    }
                    HStack{
                        Text("Penalties").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.penalties ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Passing
            VStack{
                HStack{
                    Text("Passing").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att3 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Vision").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.vision ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Crossing").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.crossing ?? "")
                    }
                    HStack{
                        Text("FK Accuracy").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.fkacc ?? "")
                    }
                    HStack{
                        Text("Short Passing").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.shortpass ?? "")
                    }
                    HStack{
                        Text("Long Passing").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.longpass ?? "")
                    }
                    HStack{
                        Text("Curve").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.curve ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Dribbling
            VStack{
                HStack{
                    Text("Dribbling").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att4 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                
                if self.statsExpanded {
                    HStack{
                        Text("Agility").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.agility ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Balance").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.balance ?? "")
                    }
                    HStack{
                        Text("Reactions").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.reactions ?? "")
                    }
                    HStack{
                        Text("Ball Control").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.ballcontrol ?? "")
                    }
                    HStack{
                        Text("Dribbling").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.dribbling ?? "")
                    }
                    HStack{
                        Text("Composure").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.composure ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Defending
            VStack{
                HStack{
                    Text("Defending").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att5 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if statsExpanded {
                    HStack{
                        Text("Interception").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.tactaware ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Heading Accuracy").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.headingacc ?? "")
                    }
                    HStack{
                        Text("Defensive Awareness").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.marking ?? "")
                    }
                    HStack{
                        Text("Standing Tackle").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.standingtackle ?? "")
                    }
                    HStack{
                        Text("Sliding Tackle").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.slidetackle ?? "")
                    }.padding(.bottom, paddingBottom)
                }
            }
            
            //MARK: - Physicality
            VStack{
                HStack{
                    Text("Physicality").bold().font(statsExpanded ? .title2 : .body).foregroundStyle(Color.secondary)
                    Spacer()
                    Text(stats?.att6 ?? "").font(statsExpanded ? .title2 : .body)
                }
                
                if self.statsExpanded {
                    HStack{
                        Text("Jumbing").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.jumping ?? "")
                    }.padding(.top, paddingTop)
                    HStack{
                        Text("Stamina").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.stamina ?? "")
                    }
                    HStack{
                        Text("Strength").foregroundStyle(Color.secondary)
                        Spacer()
                        Text(stats?.strength ?? "")
                    }
                    HStack{
                        Text("Agression").foregroundStyle(Color.secondary)
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
