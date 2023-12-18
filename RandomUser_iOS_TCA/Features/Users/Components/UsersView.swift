//
//  UsersView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI

struct UsersView {
    let users: [User]
    let isLoading: Bool
    let selectedUser: (User) -> Void
    let lastItemIsVisible: () -> Void
    let refresh: @MainActor () async -> Void
}

extension UsersView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users, content: item)

                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(height: 44)
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            await refresh()
        }
        .clipped()
    }
}

extension UsersView {
    private func item(_ user: User) -> some View {
        UserItem(user: user)
            .onTapGesture {
                selectedUser(user)
            }
            .onAppear {
                if user == users.last {
                    lastItemIsVisible()
                }
            }
    }
}
