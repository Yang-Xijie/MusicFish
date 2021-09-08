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
    
    // MARK: - get

    var currentTrack: MusicTrack? {
        MusicApplication.currentTrack
    }
    
    // MARK: - manipulation
    
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
            if let trackCover = Self.getCover(mp3path: mp3url) {
                // with cover
                PushNotificationWithNSImage(title: trackName, subtitle: "\(trackArtist) - \(trackAlbum)", body: operationName, nsimage: trackCover)
            } else {
                // no cover
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
    
    // MARK: - private func
    
    /// Get the cover of the mp3 file.
    ///
    /// - Parameter mp3path: path of mp3 (currentTrack as! MusicFileTrack).location)
    /// - Returns: nil - no cover for the given mp3
    private static func getCover(mp3path: URL) -> NSImage? {
        let metadata = AVURLAsset(url: mp3path).commonMetadata
        let artworkItems = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: AVMetadataIdentifier.commonIdentifierArtwork)

        if let artworkItem = artworkItems.first,
           let imageData = artworkItem.dataValue,
           let artwork = NSImage(data: imageData)
        {
            return artwork
        }
         
        return nil
    }
}
