//
//  UserView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI

struct UserView {
    let user: User
}

extension UserView: View {
    var body: some View {
        UserContentView(
            imageUrl: user.picture.large,
            fullName: user.fullName,
            accessibilities: user.accessibilities,
            expandedLocation: user.expandedLocation
        )
    }
}
