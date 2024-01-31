//
//  SearchByFilterView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//
import SwiftUI
import Combine



struct SearchByFilterView: View {
    @ObservedObject var searchFilter = Filter()
    @State var searchedPlayers : [Player] = []
    @State var presentFilterForm: Bool = false
    @State var newSearch = false
    @State var pageNum: Int = 0
    @FocusState var isInputActive: Bool
    @State var showPace: Bool = false
    @State var showShooting: Bool = false
    @State var showPassing : Bool = false
    @State var showDribbling : Bool = false
    @State var showDefending : Bool = false
    @State var showPhysical : Bool = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        print("Creating number formatter")
        return formatter
    }()
    
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach($searchedPlayers) {
                        $searchedPlayer in
                        LazyVStack {
                            NavigationLink {
                                PlayerInfoView().environment(searchedPlayer)
#if os(iOS)
                                    .toolbar(.hidden, for: .tabBar)
#endif
                            } label: {
                                SearchedPlayerCellView(player: searchedPlayer)
                            }
                        }
                    }
                }.refreshable {
                    print("Swipe down on filter view.")
                    self.searchFilter.getCardVersionsRemotely()
                }
                .sheet(isPresented: $presentFilterForm, content: {
                    
                    /*
                     Leagues can be multiple: leagues[]
                     Clubs can be multiple: clubs[]
                     Skill Moves can be multiple: skills[]
                     */
                    NavigationView{
                        
                        Form {
                            
                            Section {
                                MultiPicker(label: Text("Version\(searchFilter.selectedVersions.count > 1 ? "s" : "")"), options: searchFilter.getCardVersions(), optionToString: { $0.value }, selected: $searchFilter.selectedVersions)
                            } header: {
                                Text("Card Versions")
                            }
                            
                            // League can be multiple
                            Section {
                                MultiPicker(label: Text("League\(searchFilter.selectedLeagues.count > 1 ? "s" : "")"), options: searchFilter.getAllLeagues(), optionToString: { $0.value }, selected: $searchFilter.selectedLeagues)
                            } header: {
                                Text("Leagues")
                            }.onChange(of: searchFilter.selectedLeagues) { oldValue, newValue in
                                if oldValue.count > 0 && newValue.count == 0 {
                                    searchFilter.selectedTeams.removeAll()
                                }
                            }
                            
                            if searchFilter.selectedLeagues.count > 0 {
                                Section {
                                    MultiPicker(label: Text("Team\(searchFilter.selectedTeams.count > 1 ? "s" : "")"), options: searchFilter.getSpecificTeams(), optionToString: { $0.value }, selected: $searchFilter.selectedTeams)
                                } header: {
                                    Text("Teams")
                                }
                            }
                            
                            Section {
                                MultiPicker(label: Text("Position\(searchFilter.selectedPositions.count > 1 ? "s" : "")"), options: searchFilter.getAllPositions(), optionToString: { $0.value }, selected: $searchFilter.selectedPositions)
                            } header: {
                                Text("Positions")
                            }
                            
                            Section {
                                MultiPicker(label: Text("Nation\(searchFilter.selectedNations.count > 1 ? "s" : "")"), options: searchFilter.getAllNations(), optionToString: { $0.value }, selected: $searchFilter.selectedNations)
                            } header: {
                                Text("Nationality")
                            }
                            
                            Section {
                                MultiPicker(label: Text("Att W/R\(searchFilter.selectedAttWorkRates.count > 1 ? "s" : "")"), options: searchFilter.getAllWorkRates(), optionToString: { $0.value }, selected: $searchFilter.selectedAttWorkRates)
                            } header: {
                                Text("Attacking Workrates")
                            }
                            
                            Section {
                                MultiPicker(label: Text("Def W/R\(searchFilter.selectedDefWorkRates.count > 1 ? "s" : "")"), options: searchFilter.getAllWorkRates(), optionToString: { $0.value }, selected: $searchFilter.selectedDefWorkRates)
                            } header: {
                                Text("Defending Workrates")
                            }
                            
                            
                            Section {
                                MultiPicker(label: Text("Skill Moves"), options: searchFilter.getStarRatings(), optionToString: { $0.value }, selected: $searchFilter.selectedSkills)
                            } header: {
                                Text("Skill Moves")
                            }
                            
                            Section {
                                MultiPicker(label: Text("Weak Foot"), options: searchFilter.getStarRatings(), optionToString: { $0.value }, selected: $searchFilter.selectedWeakFoots)
                            } header: {
                                Text("Weak Foot")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxRating, in: 1.0...99.0, step: 1.0)
                                    NumberTextField(val: $searchFilter.selectedMaxRating, isInputActive: $isInputActive, formatter: self.formatter)
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinRating, in: 1.0...99.0, step: 1.0)
                                    NumberTextField(val: $searchFilter.selectedMinRating, isInputActive: $isInputActive, formatter: self.formatter)
                                }
                            } header: {
                                Text("Overall Rating")
                            }
                            
                            //MARK: Pace Section
                            Section {
                                VStack {
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxPace, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxPace, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinPace, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinPace, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showPace)
                                    if showPace {
                                        VStack{
                                            HStack{
                                                Text("Acceleration").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxAcceleration, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxAcceleration, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinAcceleration, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinAcceleration, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Sprint Speed").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxSprint, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxSprint, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinSprint, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinSprint, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                        }
                                    }
                                }
                            } header: {
                                Text("Pace")
                            }
                            
                            //MARK: Shooting Section
                            Section {
                                VStack {
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxShooting, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxShooting, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinShooting, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinShooting, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showShooting)
                                    if showShooting {
                                        VStack{
                                            HStack{
                                                Text("Position").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxPosition, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxPosition, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinPosition, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinPosition, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Finishing").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxFinishing, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxFinishing, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinFinishing, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinFinishing, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Shot Power").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxShotPower, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxShotPower, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinShotPower, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinShotPower, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Long Shot").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxLongShot, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxLongShot, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinLongShot, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinLongShot, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Volley").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxVolleys, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxVolleys, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinVolleys, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinVolleys, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            
                                            HStack{
                                                Text("Penalties").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                                Spacer()
                                            }.padding(.top, 5)
                                            HStack {
                                                Text("Max").font(.callout)
                                                Slider(value: $searchFilter.selectedMaxPenalties, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMaxPenalties, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                            HStack {
                                                Text("Min").font(.callout)
                                                Slider(value: $searchFilter.selectedMinPenalties, in: 1.0...99.0, step: 1.0)
                                                NumberTextField(val: $searchFilter.selectedMinPenalties, isInputActive: $isInputActive, formatter: self.formatter)
                                            }
                                        }
                                    }
                                }
                            } header: {
                                Text("Shooting")
                            }
                            
                            
                            //MARK: Passing Section
                            Section {
                                VStack {
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxPassing, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinPassing, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showPassing)
                                    if showPassing {
                                        HStack{
                                            Text("Vision").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxVision, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxVision, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinVision, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinVision, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Crossing").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxCrossing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxCrossing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinCrossing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinCrossing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Freekick Accuracy").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxFkAcc, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxFkAcc, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinFkAcc, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinFkAcc, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Short Passing").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxShortPassing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxShortPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinShortPassing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinShortPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Long Passing").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxLongPassing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxLongPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinLongPassing, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinLongPassing, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Curve").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxCurve, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxCurve, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinCurve, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinCurve, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                    }
                                }
                            } header: {
                                Text("Passing")
                            }
                            
                            //MARK: Dribbling Section
                            Section {
                                VStack {
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxDribbling, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxDribbling, isInputActive: $isInputActive, formatter: self.formatter)
                                        
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinDribbling, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinDribbling, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showDribbling)
                                    if showDribbling {
                                        HStack{
                                            Text("Agility").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxAgility, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxAgility, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinAgility, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinAgility, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Balance").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxBalance, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxBalance, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinBalance, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinBalance, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Reaction").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxReaction, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxReaction, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinReaction, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinReaction, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Ball Control").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxBallControl, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxBallControl, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinBallControl, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinBallControl, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                    }
                                }
                            } header: {
                                Text("Dribbling")
                            }
                            
                            //MARK: Defending Section
                            Section {
                                VStack {
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxDefending, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxDefending, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinDefending, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinDefending, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showDefending)
                                    if showDefending {
                                        HStack{
                                            Text("Interception").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxInterception, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxInterception, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinInterception, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinInterception, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Heading Accuracy").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxHeadAcc, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxHeadAcc, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinHeadAcc, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinHeadAcc, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Marking").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxMarking, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxMarking, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinMarking, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinMarking, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Standing Tackle").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxStandingTackle, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxStandingTackle, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinStandingTackle, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinStandingTackle, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        
                                        HStack{
                                            Text("Sliding Tackle").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxSlidingTackle, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxSlidingTackle, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinSlidingTackle, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinSlidingTackle, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                    }
                                }
                            } header: {
                                Text("Defending")
                            }
                            
                            
                            //MARK: Physical Section
                            Section {
                                VStack{
                                    HStack{
                                        Text("Max")
                                        Slider(value: $searchFilter.selectedMaxPhysical, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMaxPhysical, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    HStack{
                                        Text("Min")
                                        Slider(value: $searchFilter.selectedMinPhysical, in: 1.0...99.0, step: 1.0)
                                        NumberTextField(val: $searchFilter.selectedMinPhysical, isInputActive: $isInputActive, formatter: self.formatter)
                                    }
                                    SectionDivider(show: $showPhysical)
                                    if showPhysical {
                                        HStack{
                                            Text("Jumping").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxJumping, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxJumping, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinJumping, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinJumping, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack{
                                            Text("Stamina").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxStamina, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxStamina, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinStamina, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinStamina, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack{
                                            Text("Strength").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxStrength, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxStrength, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinStrength, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinStrength, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack{
                                            Text("Agression").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxAgression, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxAgression, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinAgression, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinAgression, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack{
                                            Text("Composure").bold().font(.subheadline).textCase(.uppercase).foregroundColor(.secondary).fontWeight(.light)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text("Max").font(.callout)
                                            Slider(value: $searchFilter.selectedMaxComposure, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMaxComposure, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                        HStack {
                                            Text("Min").font(.callout)
                                            Slider(value: $searchFilter.selectedMinComposure, in: 1.0...99.0, step: 1.0)
                                            NumberTextField(val: $searchFilter.selectedMinComposure, isInputActive: $isInputActive, formatter: self.formatter)
                                        }
                                    }
                                }
                            } header: {
                                Text("Physicality")
                            }
                            
                            
                            // MARK: Button to search
                            Section{
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        newSearch = true
                                        pageNum = 0
                                        presentFilterForm.toggle()
                                        searchPlayers()
                                    }) {
                                        Text("Search")
                                            .padding(.vertical, 15)
                                            .padding(.horizontal, 55)
                                            .foregroundColor(.white)
                                            .background(.blue)
                                            .cornerRadius(25)
                                    }
                                    Spacer()
                                }
                            }.listRowBackground(Color.clear)
                            
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard){
                                Spacer()
                                Button {
                                    isInputActive = false
                                } label: { Text("Done").foregroundStyle(Color.primary) }
                            }
                            ToolbarItemGroup(placement: .destructiveAction) {
                                
                                Button {
//                                    print("you pressed to delete filters")
                                    self.searchFilter.clearFilters()
                                } label: {
//                                    Label("Clear Filters", systemImage: "xmark.circle.fill")
//                                        .labelStyle(.titleAndIcon)
                                    HStack {
                                        Text("Clear")
                                        Image(systemName: "xmark.circle.fill")
                                    }.foregroundStyle(Color.red)
//                                        .symbolEffect(.bounce.down.byLayer)
                                }
                            }
                        }
                        .navigationTitle("Filters")//.matchedGeometryEffect(id: "filter", in: nameSpace)
                        
                    }
                }
                )
                .navigationTitle(Text("Filter Search"))
                .toolbar{
                    
                    Button {
                        presentFilterForm.toggle()
                    } label: {
                        Text("Filters")
                        Image(systemName:"line.3.horizontal.decrease.circle.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button {
                        isInputActive = false
                    } label: { Text("Done").foregroundStyle(Color.primary) }
                }
            }
        }
    }
    
    func searchPlayers(){
        let q = searchFilter.getQuery()
        print("QueryFilters:", q)
        
        ContentService.shared.searchPlayers(filter: q, page: self.pageNum) { players in
            if newSearch {
                newSearch = false
                DispatchQueue.main.async {
                    searchedPlayers = players
                }
            } else {
                DispatchQueue.main.async {
                    searchedPlayers.append(contentsOf: players)
                }
            }
            if players.count == 28 && searchedPlayers.count < 200 {
                print("Searching again as", players.count, "on page", self.pageNum)
                self.pageNum += 1
                searchPlayers()
            }
            
        }
    }
}



#Preview {
    SearchByFilterView(searchedPlayers: [Player]())
}
