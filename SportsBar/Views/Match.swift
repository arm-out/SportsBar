//
//  Match.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/22/24.
//

import SwiftUI

struct Match: View {
    var game: GameVM

    var body: some View {
        HStack {
            // Away Team
            VStack {
                Image(game.away)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                Text(game.away)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            if game.status == "notstarted" {
                Text(game.time)
                    .foregroundColor(Color.gray)
                    .frame(alignment: .center)
            }
            else if game.status == "inprogress" {
                VStack {
                    HStack {
                        Text("\(game.awayScore)")
                        Spacer()
                        Text("-")
                        Spacer()
                        Text("\(game.homeScore)")
                    }
                    .padding(.bottom, 0.5)
                    .font(.largeTitle)
                    if game.quarter == "Halftime" {
                        Text("Halftime")
                            .foregroundColor(Color.green)
                    }
                    else {
                        Text("\(game.quarter) - \(game.timeRemainingString)")
                            .foregroundColor(Color.green)
                    }
                }
            }
            else {
                VStack {
                    HStack {
                        Text("\(game.awayScore)")
                        Spacer()
                        Text("-")
                        Spacer()
                        Text("\(game.homeScore)")
                    }
                    .padding(.bottom, 0.5)
                    .font(.largeTitle)
                    Text("Final")
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()

            // Home Team
            VStack {
                Image(game.home)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                Text(game.home)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
    }
}

#Preview {
    Match(game: GameVM(game: SportsBar.Game(home: "Pistons", away: "Bucks", startTime: 1705968000.0, status: "finished", statusDesc: "In Progress", homeScore: 43, awayScore: 78, period: "period3", periodLength: 600, overtimeLength: 0, timePlayed: 1689)))
}
