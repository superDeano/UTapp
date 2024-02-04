//
//  CompareView.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-03.
//

import SwiftUI

struct CompareView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var basePlayer: Player
    @State var comparedPlayers: [Player] = []
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical]){
                LazyVStack(alignment: .leading) {
                    HStack(alignment: .top){
                        //MARK: Base Player
                        VStack(alignment: .center){
                            MediumCardView().environment(basePlayer)
                            PlayerBioView(player: $basePlayer)
                                .padding(.bottom, 5)
                            Divider()
                            AllStatsView(stats: $basePlayer.stats)
                                .padding(.trailing, 5)
//                                .border(Color.blue)
                        }
                        .padding(.bottom, 5)
                        .padding(.horizontal, 5)
                        .border(Color.secondary)
                        .frame(width: 350)
                        
                        //MARK: Compared Players
                        ForEach(0..<self.comparedPlayers.count, id: \.self){
                            comparedPlayer in
                            VStack{
                                ZStack(alignment: .top) {
                                    HStack {
                                        Button {
                                            self.comparedPlayers.remove(at: comparedPlayer)
                                        } label: {
                                            Image(systemName: "xmark.circle").resizable().scaledToFit()
                                                .frame(width: 50)
                                        }.position(x: 325, y: 35)
                                    }
                                    VStack{
                                        MediumCardView().environment(self.comparedPlayers[comparedPlayer])
                                            PlayerBioView(player: .constant(self.comparedPlayers[comparedPlayer]))
                                            .padding(.bottom, 5)
                                        Divider()
                                        AllStatsView(stats: .constant(self.comparedPlayers[comparedPlayer].stats))
                                    }.padding(.bottom, 5)
                                }
                            }
                            .frame(width: 350)
                            .padding(.horizontal, 10)
                            .border(Color.secondary)
                        }
                        
                    }.frame(alignment: .top)

                    
                }
            }
            .defaultScrollAnchor(.topLeading)
            .scrollClipDisabled()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text("Cancel")
                        }
                    }
                }
                
                //MARK: Adding
                if self.comparedPlayers.count < 3 {
                    ToolbarItem(placement: .primaryAction){
                        Button {
                            // TODO: Search and Add Player to compare
                            self.comparedPlayers.append(self.basePlayer)
                        } label: {
                            HStack {
                                Text("Add")
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Comparing \(basePlayer.cardname)")
        }
    }
}

#Preview {
    CompareView(basePlayer: .constant(Player(withId: "41")))
}
