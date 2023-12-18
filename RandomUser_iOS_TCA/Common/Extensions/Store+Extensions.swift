//
//  Store+Extensions.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import Combine
import ComposableArchitecture

extension Store {
    @MainActor
    func send(
        _ action: Action,
        `while` isInFlight: @escaping (State) -> Bool
    ) async {
        send(action)
        await withUnsafeContinuation { continuation in
            var cancellable: Cancellable?
            cancellable = publisher
                .filter { !isInFlight($0) }
                .prefix(1)
                .sink { _ in
                    continuation.resume(returning: ())
                    _ = cancellable
                }
        }
    }
}
