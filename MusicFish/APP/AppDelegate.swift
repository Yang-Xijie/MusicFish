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

        KeyboardShortcuts.onKeyDown(for: .nextTrack) {
            MusicController.shared.nextTrack()
        }
        KeyboardShortcuts.onKeyDown(for: .playpause) {
            MusicController.shared.playpause()
        }
        KeyboardShortcuts.onKeyDown(for: .previousTrack) {
            MusicController.shared.previousTrack()
        }

        KeyboardShortcuts.onKeyDown(for: .volumeUp) {
            MusicController.shared.volumeUp()
        }
        KeyboardShortcuts.onKeyDown(for: .volumeDown) {
            MusicController.shared.volumeDown()
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

    private func RequestNotificationCenterAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print(Log().error + error.localizedDescription)
            }
        }
    }

//    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//        if let window = sender.windows.first {
//            if flag {
//                window.orderFront(nil)
//            } else {
//                window.makeKeyAndOrderFront(nil)
//            }
//        }
//
//        return true
//    }

    /// make window appear when dock icon clicked
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let window = sender.windows.first {
            if flag {
                window.orderFront(nil)
            } else {
                window.makeKeyAndOrderFront(nil)
            }
        }
        // true if you want the application to perform its normal tasks
        // or false if you want the application to do nothing.
        return true
    }
}
