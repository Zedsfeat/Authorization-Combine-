//
//  AuthorizationView.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import SwiftUI

struct AuthorizationView: View {
    
    @StateObject private var viewModel = AuthorizationViewModel()
    
    private let screen = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.dark
                .ignoresSafeArea()
            
            
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    Image("AuthImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screen / 1.5,
                               height: screen / 1.5)
                        .padding(20)
                    
                    
                    Text("Authorization")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    
                    
                    VStack(spacing: 15) {
                        // Email
                        AuthTextFieldView(title: "Email",
                                          text: $viewModel.email,
                                          prompt: viewModel.emailPrompt)
                        
                        // Phone number
                        AuthTextFieldView(title: "Phone",
                                          text: $viewModel.phoneNumber,
                                          prompt: viewModel.phoneNumberPrompt)
                        .onChange(of: viewModel.phoneNumber) { _ in
                            DispatchQueue.main.async {
                                viewModel.phoneNumber = viewModel.phoneNumber.formattedMask(text: viewModel.phoneNumber, mask: "+X (XXX) XXX-XX-XX")
                            }
                        }
                        .keyboardType(.numberPad)
                        AuthTextFieldView(title: "Password",
                                          text: $viewModel.password,
                                          prompt: viewModel.passwordPrompt,
                                          isSecure: true)
                    }
                    .padding(.horizontal)
                    
                    
                    Button {
                        print("Pressed")
                    } label: {
                        ZStack {
                            if viewModel.canSubmit {
                                AnimatedGradientView(colors: [.blue, .red])
                            } else {
                                Rectangle()
                                    .foregroundColor(.gray)
                            }
                            
                            Text("Login")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            
                        }
                        .cornerRadius(10)
                        .frame(width: 70, height: 35)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .disabled(!viewModel.canSubmit)
                }
            }
        }
    }
    
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
