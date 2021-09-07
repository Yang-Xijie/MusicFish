// AppDelegate.swift

import Cocoa
import KeyboardShortcuts

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: - Control Panel

        KeyboardShortcuts.onKeyUp(for: .playpause) {
            MusicController.shared.playpause()
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}
}
