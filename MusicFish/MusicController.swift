// MusicController.swift

import AVKit
import Cocoa
import ScriptingBridge
import UserNotifications

class MusicController {
    static let shared = MusicController()
    
    let MusicApplication: AnyObject
    
    init() {
        MusicApplication = SBApplication(bundleIdentifier: "com.apple.Music")!
    }

    var currentTrack: MusicTrack? {
        MusicApplication.currentTrack
    }
    
    func playpause() {
        let operationName = "playpause"
        // toggle the playing/paused state of the current track
        MusicApplication.playpause()
        
        if let currentTrack = MusicApplication.currentTrack,
           let trackName = currentTrack.name?.description,
           let trackArtist = currentTrack.artist?.description,
           let trackAlbum = currentTrack.album?.description,
           let mp3url = (currentTrack as! MusicFileTrack).location
        {
            if let trackCover = Self.getCover(filepath: mp3url) {
                // 有封面
                PushNotificationWithNSImage(title: trackName, subtitle: "\(trackArtist) - \(trackAlbum)", body: operationName, nsimage: trackCover)
            } else {
                // 无封面
                PushNotification(title: trackName, subtitle: "\(trackArtist) - \(trackAlbum)", body: operationName)
            }
        } else {
            print(Log().error + "no currentTrack")
        }
    }
    
    func nextTrack() {
        // advance to the next track in the current playlist
        MusicApplication.nextTrack()
    }
    
    func previousTrack() {
        // return to the previous track in the current playlist
        MusicApplication.previousTrack()
    }
    
    // nil - no cover of current music
    private static func getCover(filepath: URL) -> NSImage? {
        let metadata = AVURLAsset(url: filepath).commonMetadata
        let artworkItems = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: AVMetadataIdentifier.commonIdentifierArtwork)

        if let artworkItem = artworkItems.first {
            if let imageData = artworkItem.dataValue {
                if let artwork = NSImage(data: imageData) {
                    return artwork
                }
            }
        }
        
        return nil
    }
}
