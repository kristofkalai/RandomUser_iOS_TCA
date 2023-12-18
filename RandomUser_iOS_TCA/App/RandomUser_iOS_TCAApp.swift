//
//  RandomUser_iOS_TCAApp.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct RandomUser_iOS_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            UsersScreenView(store: Store(
                initialState: .init(users: .init(), isLoading: false, seed: UUID().uuidString)) {
                    UsersFeature()
                }
            )
        }
    }
}
