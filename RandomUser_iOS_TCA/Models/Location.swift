//
//  Location.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import Foundation

struct Location: Codable, Equatable {
    let city: String
    let country: String
    let state: String
    let street: Street
}
