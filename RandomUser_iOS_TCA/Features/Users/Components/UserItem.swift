//
//  UserItem.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI

struct UserItem {
    let user: User
}

extension UserItem: View {
    var body: some View {
        HStack {
            UserImageView(imageUrl: user.picture.medium)
                .frame(width: 66)

            VStack(alignment: .leading) {
                Text(user.fullName)
                    .font(.title)
                    .bold()

                HStack {
                    Text(user.email)
                        .font(.caption)

                    Spacer()

                    Text(user.gender)
                        .font(.footnote)
                        .italic()
                }
            }

            Spacer()
        }
        .frame(height: 66)
    }
}
