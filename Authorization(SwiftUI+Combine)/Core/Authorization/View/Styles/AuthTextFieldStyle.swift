//
//  AuthTextFieldStyle.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import SwiftUI

struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .textFieldStyle(.plain)
            .fontDesign(.rounded)
            .padding(.horizontal, 8)
            .frame(height: 45)
            .foregroundColor(.white)
            .accentColor(.pink)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}


