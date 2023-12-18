//
//  User.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let name: Name
    let picture: Picture
    let gender: String
    let email: String
    let phone: String
    let cell: String
    let location: Location

    var id: String {
        email
    }
}
