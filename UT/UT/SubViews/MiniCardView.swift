//
//  MiniCardView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-09.
//

import SwiftUI

struct MiniCardView: View {
    
    var player: Player
#if os(iOS)
    var textColour = Color(UIColor.darkGray)
#else
    var textColour = Color(Color.gray)
#endif
    
    init(player: Player) {
        self.player = player
        self.textColour = Color.init(hexStr: self.player.itemInfo?.color ?? "453A22")
    }
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: self.player.itemInfo?.backgroundImage ?? "\(ContentService.getCardImagesUrl() + player.rare).png")){
                image in image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
//#if DEBUG
//                Image("Cards/42").resizable().aspectRatio(contentMode: .fit)
//#else
                ProgressView()
//#endif
            }
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Text(player.rating).foregroundStyle(self.textColour).fontWeight(.bold).scaledToFill()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

extension Color {
    init(hexStr: String, opacity: Double = 1.0) {
        var hexStr: String = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hexStr.hasPrefix("#") {
            _ = hexStr.removeFirst()
        }
        let hex = Int(exactly: hexStr.hexaToDecimal)!
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension StringProtocol {
    func dropping<S: StringProtocol>(prefix: S) -> SubSequence { hasPrefix(prefix) ? dropFirst(prefix.count) : self[...] }
    var hexaToDecimal: Int { Int(dropping(prefix: "0x"), radix: 16) ?? 0 }
    var hexaToBinary: String { .init(hexaToDecimal, radix: 2) }
    var decimalToHexa: String { .init(Int(self) ?? 0, radix: 16) }
    var decimalToBinary: String { .init(Int(self) ?? 0, radix: 2) }
    var binaryToDecimal: Int { Int(dropping(prefix: "0b"), radix: 2) ?? 0 }
    var binaryToHexa: String { .init(binaryToDecimal, radix: 16) }
}

#if DEBUG
struct testView: View {
    @EnvironmentObject var test: GetItemInfo
    var body: some View {
        Text("Test view2!")
        MiniCardView(player: Player())//.environmentObject(test)
    }
}
#endif
#Preview {
    Group {
//       testView().environmentObject(GetItemInfo())
    MiniCardView(player: Player())//.environmentObject(GetItemInfo())
    }//.environmentObject(GetItemInfo())
}
