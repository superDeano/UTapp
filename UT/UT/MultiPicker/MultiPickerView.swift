//
//  MultiPickerView.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//

import SwiftUI

struct MultiPickerView<Selectable: Identifiable & Hashable>: View {
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    @State var searchText: String = ""
    @Binding var selected: Set<Selectable>
    
    
//    var searchResults: [Selectable] {
//           if searchText.isEmpty {
//               return options
//           } else {
//               return options.filter { $0.self(searchText) }
//           }
//       }
    
    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: { toggleSelection(selectable: selectable) }) {
                    HStack {
                        Text(optionToString(selectable))//.foregroundStyle(Color.white)
                        Spacer()
                        if selected.contains(where: { $0.id == selectable.id }) {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }.tag(selectable.id)
            }
        }//.searchable(text: $searchText, prompt: "")
#if os(iOS)
            .listStyle(GroupedListStyle())
        #endif
            .toolbar {
                ToolbarItem(placement: .destructiveAction){
                    Button{
                        selected.removeAll()
                    }label: {
                        Text("Clear")
                        Image(systemName: "clear.fill")
                    }.foregroundStyle(Color.red)
                }
            }
    }
    
    private func toggleSelection(selectable: Selectable) {
        if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existingIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct MultiSelectionView_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }
    
    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })
    
    static var previews: some View {
        NavigationView {
            MultiPickerView(
                options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                optionToString: { $0.string },
                selected: $selected
            )
        }
    }
}
