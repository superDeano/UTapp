//
//  NumberTextField.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-18.
//

import SwiftUI

struct NumberTextField: View {
    @Binding var val : Double
    var isInputActive: FocusState<Bool>.Binding
    var formatter: NumberFormatter
    var frameWidth: CGFloat = 40
    var frameHeight: CGFloat = 35
    
    var body: some View {
        TextField("\(String(format:"%.0f", val))", value: $val, formatter: self.formatter)
            .autocorrectionDisabled()
#if os(iOS)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
#endif
            .padding(.horizontal, 2)
            .fixedSize(horizontal: false, vertical: true)
            .focused(isInputActive)
            .frame(width: frameWidth, height: frameHeight)
            .textFieldStyle(SearchStyle())
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
    NumberTextField(val: .constant(0.0), isInputActive: FocusState<Bool>().projectedValue, formatter: NumberFormatter())
}
