//
//  SeedGenerator.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import ComposableArchitecture
import Foundation

struct SeedGenerator {
    let next: () -> String
}

extension SeedGenerator: DependencyKey {
    static let liveValue = Self {
        UUID().uuidString
    }
}

extension DependencyValues {
    var seedGenerator: SeedGenerator {
        get { self[SeedGenerator.self] }
        set { self[SeedGenerator.self] = newValue }
    }
}
