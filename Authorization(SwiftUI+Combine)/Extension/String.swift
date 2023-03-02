//
//  String.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import Foundation


extension String {
    func formattedMask(text: String, mask: String?) -> String {
        let cleanPhoneNumber = text
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        if let mask {
            for character in mask where index < cleanPhoneNumber.endIndex {
                if character == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(character)
                }
            }
        }
        return result
    }
}

