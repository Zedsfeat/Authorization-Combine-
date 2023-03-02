//
//  Authorization_SwiftUI_Combine_App.swift
//  Authorization(SwiftUI+Combine)
//
//  Created by zedsbook on 01.03.2023.
//

import SwiftUI

@main
struct Authorization_SwiftUI_Combine_App: App {
    var body: some Scene {
        WindowGroup {
            AuthorizationView()
                .preferredColorScheme(.dark)
        }
    }
}
