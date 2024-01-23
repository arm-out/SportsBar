//
//  GamesList.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import SwiftUI

struct GamesList: View {
    @StateObject var vm: GameListVM

    var title: String
    var index: Int

    private var list: [GameVM] {
        switch title {
        case "NBA":
            return vm.nba
        case "NFL":
            return vm.nfl
        default:
            return []
        }
    }

    var body: some View {
        if list.isEmpty {
            Text("No games to show")
                .frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                .padding(.top, 25)
        }

        List(list, id: \.home) { game in
            if list.isEmpty {
                Text("No games to show")
            }

            Match(game: game)
        }
        .task {
            await vm.populateNBA()
            await vm.populateNFL()
        }
    }
}

#Preview {
    GamesList(vm: GameListVM(), title: "NFL", index: 1)
}
