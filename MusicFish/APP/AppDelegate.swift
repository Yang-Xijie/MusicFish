// AppDelegate.swift

import Cocoa
import KeyboardShortcuts

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: - Control Panel

        KeyboardShortcuts.onKeyDown(for: .playpause) {
            MusicController.shared.playpause()
            print(Log().string + "onKeyDown playpause")
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}
}
