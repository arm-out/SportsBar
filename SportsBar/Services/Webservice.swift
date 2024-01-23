//
//  Webservice.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import Foundation

enum NetworkError: Error {
    case InvalidResponse
}

class Webservice {
    func getGames(url: URL) async throws -> [Game] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.InvalidResponse
        }

        return try JSONDecoder().decode([Game].self, from: data)
    }
}
