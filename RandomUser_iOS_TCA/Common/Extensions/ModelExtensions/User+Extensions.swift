//
//  User+Extensions.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import Foundation

extension User {
    var fullName: String {
        PersonNameComponentsFormatter.shared.string(from: .init(
            namePrefix: name.title,
            givenName: name.first,
            familyName: name.last)
        )
    }

    var accessibilities: String {
        "Contacts:\n\tEmail: \(email)\n\tCellphone: \(cell)\n\tPhone: \(phone)"
    }

    var expandedLocation: String {
        "Address:\n\t\(location.country), \(location.state), \(location.city)\n\tStreet \(location.street.name) \(location.street.number)"
    }
}
