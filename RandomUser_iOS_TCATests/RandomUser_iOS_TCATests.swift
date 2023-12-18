//
//  RandomUser_iOS_TCATests.swift
//  RandomUser_iOS_TCATests
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture
import XCTest
@testable import RandomUser_iOS_TCA

@MainActor
final class RandomUser_iOS_TCATests: XCTestCase {
    func testLoadingState() async {
        let exampleUser = User(
            name: .init(first: "", last: "", title: ""),
            picture: .init(large: "", medium: ""),
            gender: "",
            email: "",
            phone: "",
            cell: "",
            location: .init(city: "", country: "", state: "", street: .init(name: "", number: 0))
        )
        let nextSeed = "nextSeed"

        let store = TestStore(initialState: UsersFeature.State(users: [], isLoading: false, seed: "")) {
            UsersFeature()
        } withDependencies: {
            $0.apiService = .init { _ in
                [exampleUser]
            }
            $0.seedGenerator = .init {
                nextSeed
            }
        }

        await store.send(.refresh) {
            $0 = .init(users: $0.users, isLoading: true, seed: nextSeed)
        }
        await store.receive(\.replaceUsers) {
            $0 = .init(users: [exampleUser], isLoading: false, seed: $0.seed)
        }
    }
}
