//
//  UsersScreenView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture
import SwiftUI

struct UsersScreenView {
    let store: StoreOf<UsersFeature>
}

extension UsersScreenView: View {
    var body: some View {
        NavigationStack {
            WithViewStore(store, observe: { $0 }) {
                UsersView(users: $0.users, isLoading: $0.isLoading, selectedUser: {
                    store.send(.userIsSelected($0))
                }, lastItemIsVisible: {
                    store.send(.getMoreData)
                }, refresh: {
                    await store.send(.refresh, while: \.isLoading)
                })
            }
            .onAppear {
                store.send(.viewIsAppearing)
            }
            .sheet(store: store.scope(state: \.$selectUser, action: \.selectUser)) { store in
                UserScreenView(store: store)
            }
        }
    }
}
