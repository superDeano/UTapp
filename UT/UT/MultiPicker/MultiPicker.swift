//
//  MultiPicker.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-12.
//

import SwiftUI

struct MultiPicker<LabelView: View, Selectable: Identifiable & Hashable>: View {
    let label: LabelView
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    
    var selected: Binding<Set<Selectable>>
    
    private var formattedSelectedListString: String {
        ListFormatter.localizedString(byJoining: selected.wrappedValue.map { optionToString($0) })
    }
    
    var body: some View {
        NavigationLink(destination: multiSelectionView()) {
            HStack {
                label
                Spacer()
                Text(formattedSelectedListString)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private func multiSelectionView() -> some View {
        MultiPickerView(
            options: options,
            optionToString: optionToString,
            selected: selected
        )
    }
}

struct MultiSelector_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }

    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })

    static var previews: some View {
        NavigationView {
            Form {
                MultiPicker<Text, IdentifiableString>(
                    label: Text("Multiselect"),
                    options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                    optionToString: { $0.string },
                    selected: $selected
                )
            }.navigationTitle("Title")
        }
    }
}
