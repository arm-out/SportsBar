//
//  Game.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import Foundation

struct Game: Decodable {
    let home: String
    let away: String
    let startTime: TimeInterval
    let status: String
    let statusDesc: String
    let homeScore: Int
    let awayScore: Int
    let period: String
    let periodLength: Int
    let overtimeLength: Int
    let timePlayed: Int
}
