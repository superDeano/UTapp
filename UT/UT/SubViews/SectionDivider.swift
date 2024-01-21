//
//  SectionDivider.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-19.
//

import SwiftUI

struct SectionDivider: View {
    @Binding var show: Bool
    var body: some View {
        VStack{
            Divider()
            HStack {
                Text(show ? "Hide" : "Show more").font(.callout).foregroundStyle(Color.blue)
                Spacer()
                Button(action: { show.toggle() }, label: {
                    if show {
                        Image(systemName: "chevron.up")
                    } else {
                        Image(systemName: "chevron.down")
                    }
                })
            }.padding(.vertical, 5)
        }
    }
}

#Preview {
    SectionDivider(show: .constant(false))
}
