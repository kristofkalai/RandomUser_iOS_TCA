//
//  UserContentView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI

struct UserContentView {
    let imageUrl: String
    let fullName: String
    let accessibilities: String
    let expandedLocation: String
}

extension UserContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(spacing: 16) {
                UserImageView(imageUrl: imageUrl)

                Text(fullName)
                    .font(.title2)
            }
            .frame(maxWidth: .infinity)

            Text(accessibilities)

            Text(expandedLocation)
        }
        .padding(32)
    }
}

#if DEBUG
#Preview {
    UserContentView(
        imageUrl: "",
        fullName: "Full name",
        accessibilities: "Accessibilities",
        expandedLocation: "expandedLocation"
    )
}
#endif
