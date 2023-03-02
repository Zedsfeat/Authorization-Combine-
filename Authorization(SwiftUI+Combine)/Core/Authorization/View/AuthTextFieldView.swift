//
//  AuthTextFieldView.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import SwiftUI

struct AuthTextFieldView: View {
    
    private var title: String
    private var text: Binding<String>
    private var prompt: String?
    private var isSecure: Bool
    
    init(title: String, text: Binding<String>, prompt: String? = nil, isSecure: Bool = false) {
        self.title = title
        self.text = text
        self.prompt = prompt
        self.isSecure = isSecure
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isSecure {
                SecureField(title, text: text)
                    .textFieldStyle(AuthTextFieldStyle())
                    .background(prompt == nil ? .white.opacity(0.1) : .red.opacity(0.15))
                    .cornerRadius(10)
            } else {
                TextField(title, text: text)
                    .textFieldStyle(AuthTextFieldStyle())
                    .background(prompt == nil ? .white.opacity(0.1) : .red.opacity(0.15))
                    .cornerRadius(10)
            }
            
            if let prompt {
                Text(prompt)
                    .foregroundColor(.red)
                    .font(.caption)
                    .fontDesign(.rounded)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
