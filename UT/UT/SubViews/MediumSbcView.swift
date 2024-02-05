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
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.quaternary)
                .aspectRatio(0.80, contentMode: .fit)
                
            VStack{
                HStack(alignment: .center) {
                    Text(sbc.name).font(.title2).bold()
                    if sbc.new {
                        Spacer()
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20, style: .circular)
                                .fill(.green)
                            Text("NEW").font(.headline).bold().fontWeight(.black)
                        }.frame(width: 60, height: 40).padding(.trailing, 15)
                    }
                }.padding(.top, 25)
                    .padding(.leading, 15)
                CachedAsyncImage(url: URL(string: "\(ContentService.getSbcLogosUrl())\(sbc.logo).png")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
        }.frame(width: 300, height: 400)
    }
}

#Preview {
    MediumSbcView(sbc: SBC())
}
