//
//  ApiService.swift
//  RandomUser_iOS_TCA
//
//  Created by Kristóf Kálai on 18/12/2023.
//

import Alamofire
import ComposableArchitecture
import Foundation

struct ApiServiceClient {
    struct UsersApiRequest {
        let page: Int
        let results: Int
        let seed: String
    }

    enum NetworkError: Error {
        case wrongUrl
    }

    let users: (UsersApiRequest) async throws -> [User]
}

extension ApiServiceClient: DependencyKey {
    static let liveValue = Self { input in
        guard let url = createUrl(input.page, input.results, input.seed) else {
            throw NetworkError.wrongUrl
        }

        let dataTask = AF.request(url).serializingDecodable(UserResult.self)

        switch await dataTask.result {
        case let .success(success): return success.results
        case let .failure(failure): throw failure
        }
    }

    private static func createUrl(_ page: Int, _ results: Int, _ seed: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "inc", value: "name,picture,gender,location,email,phone,cell"),
            URLQueryItem(name: "page", value: .init(page)),
            URLQueryItem(name: "results", value: .init(results)),
            URLQueryItem(name: "seed", value: .init(seed))
        ]
        var urlComponents = URLComponents(string: "https://randomuser.me/api/1.3/")
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

extension DependencyValues {
    var apiService: ApiServiceClient {
        get { self[ApiServiceClient.self] }
        set { self[ApiServiceClient.self] = newValue }
    }
}
