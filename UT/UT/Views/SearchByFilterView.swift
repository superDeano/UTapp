//
//  SearchByFilterView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//
import SwiftUI
import Combine

//let allPositions = Filter().getAllPositions()



struct SearchByFilterView: View {
    @ObservedObject var searchFilter = Filter()
    @State var searchedPlayers : [Player] = []
    @State var presentFilterForm: Bool = false
    @State var newSearch = false
    @State var pageNum: Int = 0
    @FocusState var isInputActive: Bool
    
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
                }
                .sheet(isPresented: $presentFilterForm, content: {
                    
                    /*
                     Leagues can be multiple: leagues[]
                     Clubs can be multiple: clubs[]
                     Skill Moves can be multiple: skills[]
                     */
                    NavigationView{
                        
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
                            }.padding(.top, 15)
                            
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
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMaxRating))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxRating))", value: $searchFilter.selectedMaxRating, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinRating, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinRating))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinRating))", value: $searchFilter.selectedMinRating, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Overall Rating")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxPace, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMaxPace))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxPace))", value: $searchFilter.selectedMaxPace, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinPace, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinPace))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinPace))", value: $searchFilter.selectedMinPace, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Pace")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxShooting, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMaxShooting))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxShooting))", value: $searchFilter.selectedMaxShooting, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinShooting, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinShooting))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinShooting))", value: $searchFilter.selectedMinShooting, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Shooting")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxPassing, in: 1.0...99.0, step: 1.0)
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxPassing))", value: $searchFilter.selectedMaxPassing, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinPassing, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinPassing))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinPassing))", value: $searchFilter.selectedMinPassing, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Passing")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxDribbling, in: 1.0...99.0, step: 1.0)
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxDribbling))", value: $searchFilter.selectedMaxDribbling, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                    
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinDribbling, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinDribbling))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinDribbling))", value: $searchFilter.selectedMinDribbling, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Dribbling")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxDefending, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMaxDefending))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxDefending))", value: $searchFilter.selectedMaxDefending, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinDefending, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinDefending))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinDefending))", value: $searchFilter.selectedMinDefending, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Defending")
                            }
                            
                            Section {
                                HStack{
                                    Text("Max")
                                    Slider(value: $searchFilter.selectedMaxPhysical, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMaxPhysical))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMaxPhysical))", value: $searchFilter.selectedMaxPhysical, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                                HStack{
                                    Text("Min")
                                    Slider(value: $searchFilter.selectedMinPhysical, in: 1.0...99.0, step: 1.0)
                                    //                                    Text("\(String(format:"%.0f", searchFilter.selectedMinPhysical))")
                                    TextField("\(String(format:"%.0f", searchFilter.selectedMinPhysical))", value: $searchFilter.selectedMinPhysical, formatter: self.formatter)
                                        .autocorrectionDisabled()
                                        .keyboardType(.numberPad)
                                        .padding(.horizontal, 2)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .focused($isInputActive)
                                        .frame(width: 40, height: 35)
                                        .textFieldStyle(SearchStyle())
                                }
                            } header: {
                                Text("Physicality")
                            }//.collap
                            
                            
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
                        }
                        
                    }
                }
                )
                .navigationTitle(Text("Filter Search"))
                .toolbar{
                    
                    Button {
                        presentFilterForm.toggle()
                    } label: {
                        Text("Filters")
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

// Structure creating a custom textFieldStyle
struct SearchStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 5).fill(Color.secondary).opacity(0.35).allowsHitTesting(false)
            )
    }
}

#Preview {
    SearchByFilterView(searchedPlayers: [Player]())
}
