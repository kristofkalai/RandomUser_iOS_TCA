//
//  UserFeature.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture

@Reducer
struct UserFeature {
    struct State: Equatable {
        let user: User
    }

    enum Action {
        case dismissButtonTapped
    }
}

extension UserFeature {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped: .none
            }
        }
    }
}
