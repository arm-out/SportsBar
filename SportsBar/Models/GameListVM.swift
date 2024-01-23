//
//  GamesVM.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import Foundation

@MainActor
class GameListVM: ObservableObject {
    @Published var nba: [GameVM] = []
    @Published var nfl: [GameVM] = []

    func populateNBA() async {
        let apiURL = Constants.Urls.NBAGames
        do {
            let games = try await Webservice().getGames(url: apiURL!)
            nba = games.map(GameVM.init)
        } catch {
            print(error)
        }
    }

    func populateNFL() async {
        let apiURL = Constants.Urls.NFLGames
        do {
            let games = try await Webservice().getGames(url: apiURL!)
            nfl = games.map(GameVM.init)
        } catch {
            print(error)
        }
    }
}

struct GameVM {
    private var game: Game

    init(game: Game) {
        self.game = game
    }

    var home: String {
        game.home
    }

    var away: String {
        game.away
    }

    var time: String {
        let date = Date(timeIntervalSince1970: game.startTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter.string(from: date)
    }

    var status: String {
        game.status
    }

    var quarter: String {
        switch game.period {
        case "period1":
            "Q1"
        case "period2":
            "Q2"
        case "period3":
            "Q3"
        case "period4":
            "Q4"
        case "overtime":
            "OT"
        default:
            ""
        }
    }

    var awayScore: Int {
        game.awayScore
    }

    var homeScore: Int {
        game.homeScore
    }

    var timeRemaining: Int {
        switch game.period {
        case "period1":
            game.periodLength - game.timePlayed
        case "period2":
            (game.periodLength * 2) - game.timePlayed
        case "period3":
            (game.periodLength * 3) - game.timePlayed
        case "period4":
            (game.periodLength * 4) - game.timePlayed
        case "overtime":
            (game.periodLength * 4) + game.overtimeLength - game.timePlayed
        default:
            0
        }
    }

    var timeRemainingString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
}
