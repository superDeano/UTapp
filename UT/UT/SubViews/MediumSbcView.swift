//
//  MediumSbcView.swift
//  UT
//
//  Created by Dean Chong San on 2024-02-04.
//

import SwiftUI
import CachedAsyncImage

struct MediumSbcView: View {
    @State var sbc: SBC
    @State private var expanded = false
    //    @Namespace private var nameSpace
    
    var body: some View {
        Button {
            self.expanded = true
        } label: {
            //MARK: CardView
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.quaternary)
                        .aspectRatio(0.69, contentMode: .fit)
                    VStack{
                        HStack(alignment: .top) {
                            Text(sbc.name).font(.title3).bold().multilineTextAlignment(.leading).fontWidth(.compressed)
                            if sbc.new {
                                Spacer()
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20, style: .circular)
                                        .fill(.green)
                                    Text("NEW").font(.caption).bold().fontWeight(.black).fontWidth(.condensed).foregroundStyle(Color.primary)
                                }.frame(width: 30, height: 20).padding(.trailing, 15)
                            }
                        }.padding(.top, 10)
                            .padding(.leading, 15)
                            .frame(alignment: .top)
                        Spacer()
                        CachedAsyncImage(url: URL(string: "\(ContentService.getSbcLogosUrl())\(sbc.logo).png")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        //                        .matchedGeometryEffect(id: "sbcLogo", in: nameSpace)
                    }.frame(maxHeight: 215)
                }
            }.frame(width: 155, height: 250, alignment: .center).padding(.horizontal, 10)
            
        }.sheet(isPresented: self.$expanded, onDismiss: {
//            self.expanded = false
            print("After dismissed", self.expanded)
        }) {
            //MARK: Expanded View
            VStack {
                HStack(alignment: .top) {
                    Text(sbc.name).bold().font(.title)
                    Spacer()
                    HStack {
                        Text(sbc.tag.uppercased())
                            .foregroundStyle(.blue)
                            .font(.subheadline)
                            .bold()
                            .padding(.all, 10)
                    }
                    .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous)
                    )
                    .cornerRadius(15)
//                    .border(Color.blue)
                }.padding(.top, 25)
                
                HStack(alignment: .top) {
                    Text(sbc.description)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Spacer()
                }.padding(.vertical, 5)
                Spacer()
                CachedAsyncImage(url: URL(string: "\(ContentService.getSbcLogosUrl())\(sbc.logo).png")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                //                .matchedGeometryEffect(id: "sbcLogo", in: nameSpace)
                
                Spacer()
                
                HStack {
                    Text("# Challenges").foregroundStyle(.secondary)
                    Spacer()
                    Text(sbc.numChallenges).font(.headline).bold()
                }
                HStack {
                    Text("Repeatable").foregroundStyle(.secondary)
                    Spacer()
                    Text(sbc.repeatable == "0" ? "Non-Repeatable" : sbc.repeatable).font(.headline).bold()
                }.padding(.vertical, 5)
                
                HStack {
                    Text("Time Left").foregroundStyle(.secondary)
                    Spacer()
                    Text(sbc.expiring).font(.headline).bold()
                }
                Spacer()
                
            }
            .padding(.horizontal, 30)
            .frame(maxHeight: .infinity)
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.automatic)
        }
    }
}

#Preview {
    MediumSbcView(sbc: SBC())
}


