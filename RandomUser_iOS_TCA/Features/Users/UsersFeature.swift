//
//  UsersFeature.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture
import Foundation

@Reducer
struct UsersFeature {
    struct State: Equatable {
        @PresentationState var selectUser: UserFeature.State?

        let users: [User]
        let isLoading: Bool
        let seed: String
    }

    enum Action {
        case viewIsAppearing
        case refresh
        case getMoreData
        case userIsSelected(User)

        case selectUser(PresentationAction<UserFeature.Action>)

        case replaceUsers([User])
        case addUsers([User])
    }

    private enum Constants {
        static let pageSize = 10
    }

    @Dependency(\.apiService) var apiService
    @Dependency(\.seedGenerator) var seedGenerator
}

extension UsersFeature {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewIsAppearing:
                let seed = state.seed
                return .run { send in
                    let result = try await apiService.users(.init(page: 1, results: Constants.pageSize, seed: seed))
                    await send(.replaceUsers(result))
                }
            case .refresh:
                state = .init(users: .init(), isLoading: true, seed: seedGenerator.next())
                let seed = state.seed
                return .run { send in
                    let result = try await apiService.users(.init(page: 1, results: Constants.pageSize, seed: seed))
                    await send(.replaceUsers(result))
                }
            case .getMoreData:
                state = .init(users: state.users, isLoading: true, seed: state.seed)
                let nextPage = Int(Double(state.users.count) / Double(Constants.pageSize) + 1)
                let seed = state.seed
                return .run { send in
                    let result = try await apiService.users(.init(page: nextPage, results: Constants.pageSize, seed: seed))
                    await send(.addUsers(result))
                }
            case let .userIsSelected(user):
                state.selectUser = .init(user: user)
                return .none

            case .selectUser(.dismiss):
                state.selectUser = nil
                return .none
            case .selectUser(.presented(.dismissButtonTapped)):
                state.selectUser = nil
                return .none
            case let .replaceUsers(users):
                state = .init(users: users, isLoading: false, seed: state.seed)
                return .none
            case let .addUsers(users):
                let currentUsers = state.users
                return .run { send in
                    await send(.replaceUsers(currentUsers + users))
                }
            }
        }
        .ifLet(\.$selectUser, action: \.selectUser) {
            UserFeature()
        }
    }
}
