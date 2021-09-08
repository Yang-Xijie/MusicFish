// AppDelegate.swift

import Cocoa
import KeyboardShortcuts
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Debug
        // Debug END

        // to send notifications on macOS
        RequestNotificationCenterAuthorization()

        // MARK: - Control Panel

        KeyboardShortcuts.onKeyDown(for: .playpause) {
            MusicController.shared.playpause()
        }

        KeyboardShortcuts.onKeyDown(for: .nextTrack) {
            MusicController.shared.nextTrack()
        }

        KeyboardShortcuts.onKeyDown(for: .previousTrack) {
            MusicController.shared.previousTrack()
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

    private func RequestNotificationCenterAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print("[NotificationCenter.requestAuthorization] error - \(error)")
            }
        }
    }
}
