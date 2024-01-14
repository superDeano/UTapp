//
//  SearchByFilterView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//
import SwiftUI

let allPositions = Filter().getAllPositions()

//let allLeagues = Leagues.leagues.map({ (key: String, value: String) in
//    GenericKeyValue(key: key, value: value)
//})

struct SearchByFilterView: View {
    @ObservedObject var searchFilter = Filter()
    @State var searchedPlayers : [Player] = []
    @State var presentFilterForm: Bool = false
    @State var newSearch = false
    @State var pageNum: Int = 0
    
    
    var body: some View {
        NavigationStack{
            List{
                ForEach($searchedPlayers) {
                    $searchedPlayer in
                    NavigationLink {
                        PlayerInfoView().environment(searchedPlayer)
                        #if os(iOS)
                            .toolbar(.hidden, for: .tabBar)
                        #endif
                    } label: {
                        HStack {
                            VStack(alignment: .leading){
                                Text(searchedPlayer.name).multilineTextAlignment(.leading)
                                Text("\(Nations.nations[searchedPlayer.nation] ?? "") | \(Leagues.leagues[searchedPlayer.league] ?? "") | \(Clubs.teams[searchedPlayer.club] ?? "")").multilineTextAlignment(.leading).fontWidth(.compressed)

                            }
                            Spacer()
                            HStack{
                                MiniCardView(player: searchedPlayer)
                            }.frame(maxWidth: 40)
                        }
                    }
                }
            }
            .sheet(isPresented: $presentFilterForm, content: {
                //            if presentFilterForm {
                /*
                 Leagues can be multiple: leagues[]
                 Clubs can be multiple: clubs[]
                 Skill Moves can be multiple: skills[]
                 */
                NavigationStack{
                    Form {
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
                            MultiPicker(label: Text("Position\(searchFilter.selectedPositions.count > 1 ? "s" : "")"), options: allPositions, optionToString: { $0.value }, selected: $searchFilter.selectedPositions)
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
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxRating))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinRating, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinRating))")
                            }
                        } header: {
                            Text("Overall Rating")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxPace, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxPace))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinPace, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinPace))")
                            }
                        } header: {
                            Text("Pace")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxShooting, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxShooting))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinShooting, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinShooting))")
                            }
                        } header: {
                            Text("Shooting")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxPassing, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxPassing))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinPassing, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinPassing))")
                            }
                        } header: {
                            Text("Passing")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxDribbling, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxDribbling))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinDribbling, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinDribbling))")
                            }
                        } header: {
                            Text("Dribbling")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxDefending, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxDefending))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinDefending, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinDefending))")
                            }
                        } header: {
                            Text("Defending")
                        }
                        
                        Section {
                            HStack{
                                Text("Max")
                                Slider(value: $searchFilter.selectedMaxPhysical, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMaxPhysical))")
                            }
                            HStack{
                                Text("Min")
                                Slider(value: $searchFilter.selectedMinPhysical, in: 1.0...99.0, step: 1.0)
                                Text("\(String(format:"%.0f", searchFilter.selectedMinPhysical))")
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
                                //                                .shadow(color: .blue, radius: 15, y: 5)
                                Spacer()
                            }
                        }.listRowBackground(Color.clear)
                    }
                }.padding(.top, 15)
            })
            .navigationTitle(Text("Filter Search"))
            .toolbar{
                //            ToolbarItem(placement: .primaryAction){
                Button {
                    presentFilterForm.toggle()
                    //                    print("Button pressed, value now is ", presentFilterForm)
                } label: {
                    Text("Filters")
                }
                //            }
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
                self.pageNum += 1
                searchPlayers()
            }
            
        }
    }
}

#Preview {
    SearchByFilterView(searchedPlayers: [Player]())
}
