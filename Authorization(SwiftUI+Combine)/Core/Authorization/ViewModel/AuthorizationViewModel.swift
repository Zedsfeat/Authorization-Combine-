//
//  AuthorizationViewModel.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import Foundation
import Combine

enum Regex: String {
    case phoneNumber = "(\\s*)?(\\+)?([- _():=+]?\\d[- _():=+]?){10,14}(\\s*)?"
    case email =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

final class AuthorizationViewModel: ObservableObject {
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var password = ""
    @Published var canSubmit = false
    
    var emailPrompt: String? {
        if email.isEmpty || isValidEmail {
            return nil
        } else {
            return "Enter valid email. Example test@test.com"
        }
    }
    
    var phoneNumberPrompt: String? {
        if phoneNumber.isEmpty || isValidPhoneNumber {
            return nil
        } else {
            return "Enter valid phone number."
        }
    }
    
    var passwordPrompt: String? {
        if password.isEmpty || isValidPassword {
            return nil
        } else {
            return "Enter valid password."
        }
    }
    
    @Published private var isValidEmail = false
    @Published private var isValidPhoneNumber = false
    @Published private var isValidPassword = false
    
    private var emailPredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    private var phoneNumberPredicate = NSCompoundPredicate(format: "SELF MATCHES %@", Regex.phoneNumber.rawValue)
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { self.emailPredicate.evaluate(with: $0) }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellable)
        
        $phoneNumber
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { self.phoneNumberPredicate.evaluate(with: $0) }
            .assign(to: \.isValidPhoneNumber, on: self)
            .store(in: &cancellable)
        
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { $0.count >= 8 }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellable)
        
        Publishers.CombineLatest3($isValidEmail, $isValidPhoneNumber, $isValidPassword)
            .map { email, phoneNumber, password in
                return (email && phoneNumber && password)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellable)
        
    }
    
}
