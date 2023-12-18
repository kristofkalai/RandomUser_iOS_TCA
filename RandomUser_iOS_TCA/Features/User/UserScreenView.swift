//
//  UserScreenView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture
import SwiftUI

struct UserScreenView {
    let store: StoreOf<UserFeature>
}

extension UserScreenView: View {
    var body: some View {
        WithViewStore(store, observe: { $0 }) { state in
            NavigationStack {
                UserView(user: state.user)
                    .toolbar {
                        Button("Dismiss") {
                            store.send(.dismissButtonTapped)
                        }
                    }
            }
        }
    }
}
