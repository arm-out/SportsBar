//
//  ContentView.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    private let tabs = ["NBA", "NFL"]
    @State private var selectedTab = 0

    @StateObject private var vm: GameListVM

    init(vm: GameListVM) {
        self._vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                ForEach(self.tabs.indices) { i in
                    Text(self.tabs[i]).tag(i)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)
            .frame(width: 70.0)

            GamesList(vm: vm, title: self.tabs[self.selectedTab], index: self.selectedTab)
        }
        .frame(width: 450, height: 500)
        .background(BlurEffectView(material: NSVisualEffectView.Material.contentBackground, blendingMode: NSVisualEffectView.BlendingMode.withinWindow))
    }
}

#Preview {
    ContentView(vm: GameListVM())
}
