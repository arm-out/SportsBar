//
//  SportsBarApp.swift
//  SportsBar
//
//  Created by Armin Suraj on 1/17/24.
//

import SwiftUI

@main
struct SportsBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(vm: GameListVM())
                .fixedSize()
        }
        .windowResizability(.contentSize)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    private var gameListVM: GameListVM!

    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        self.gameListVM = GameListVM()

        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "basketball", accessibilityDescription: "Basketball Sports Bar Icon")
            statusButton.action = #selector(self.togglePopover)
        }

        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 450, height: 500)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(vm: self.gameListVM))
    }

    @objc func togglePopover() {
        Task {
            await self.gameListVM.populateNBA()
            await self.gameListVM.populateNFL()
        }

        if let button = statusItem.button {
            if self.popover.isShown {
                self.popover.performClose(nil)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
