// AppDelegate.swift

import Cocoa
import KeyboardShortcuts
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Debug
//        if let currentTrack = MusicController.shared.MusicApplication.currentTrack {
//            let artwork = (currentTrack.artworks!().firstObject as! MusicArtwork)
//            
//            print(type(of: artwork.data))
//            print()
//            print(artwork.objectDescription)
////            PushNotification(title: "title", subtitle: "subtitle")
//        } else {
//            print(Log().error + "no currentTrack")
//        }

        // Debug END

        // to send notifications on macOS
        RequestNotificationCenterAuthorization()

        // MARK: - Control Panel

        KeyboardShortcuts.onKeyDown(for: .playpause) {
            MusicController.shared.playpause()
        }

        KeyboardShortcuts.onKeyDown(for: .nextTrack) {
            MusicController.shared.nextTrack()
//            print(Log().string + "onKeyDown nextTrack")
        }

        KeyboardShortcuts.onKeyDown(for: .previousTrack) {
            MusicController.shared.previousTrack()
        }

        // MARK: - Rating Panel

        // MARK: - Track Panel
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

    func RequestNotificationCenterAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print("[NotificationCenter.requestAuthorization] error - \(error)")
            }
        }
    }
}
