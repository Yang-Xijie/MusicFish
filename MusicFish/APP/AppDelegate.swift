// AppDelegate.swift

import Cocoa
import KeyboardShortcuts

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK: - Control Panel

        KeyboardShortcuts.onKeyDown(for: .playpause) {
            MusicController.shared.playpause()
        }

        KeyboardShortcuts.onKeyDown(for: .nextTrack) {
            MusicController.shared.nextTrack()
            print(Log().string + "onKeyDown nextTrack")
        }

        KeyboardShortcuts.onKeyDown(for: .previousTrack) {
            MusicController.shared.previousTrack()
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}
}
