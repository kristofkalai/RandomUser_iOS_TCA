//
//  UserImageView.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import SwiftUI

struct UserImageView {
    let imageUrl: String
}

extension UserImageView: View {
    var body: some View {
        AsyncImage(url: .init(string: imageUrl))
    }
}
