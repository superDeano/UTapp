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
//    @Namespace var nameSpace
    
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
                            
                            Section {
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
                            } header: {
                                Text("Pace")
                            }
                            
                            Section {
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
                            } header: {
                                Text("Shooting")
                            }
                            
                            Section {
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
                            } header: {
                                Text("Passing")
                            }
                            
                            Section {
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
                            } header: {
                                Text("Dribbling")
                            }
                            
                            Section {
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
                            } header: {
                                Text("Defending")
                            }
                            
                            Section {
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
