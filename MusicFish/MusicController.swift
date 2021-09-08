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

    /// the current targeted track
    var currentTrack: MusicTrack? {
        MusicApplication.currentTrack
    }
    
    /// is the player stopped, paused, or playing?
    var playerState: MusicEPlS {
        MusicApplication.playerState
    }
    
    /// the sound output volume (0 = minimum, 100 = maximum)
    var soundVolume: Int {
        MusicApplication.soundVolume
    }
    
    // MARK: - manipulation Control
    
    // toggle the playing/paused state of the current track
    func playpause() {
        // TODO: consider when music is not activate: use NSRunningApplication to start Music.app
        MusicApplication.playpause()
        
        let operationName: String
        let operationIcon: String
        switch playerState {
        case .stopped:
            operationName = "stopped"
            operationIcon = "􀛶"
        case .paused:
            operationName = "paused"
            operationIcon = "􀊅"
        case .playing:
            operationName = "playing"
            operationIcon = "􀊃"
        default:
            operationName = "playpause"
            operationIcon = "􀊇"
        }
        
        if let currentTrack = MusicApplication.currentTrack,
           let trackName = currentTrack.name?.description,
           let trackArtist = currentTrack.artist?.description,
           let trackAlbum = currentTrack.album?.description,
           let mp3url = (currentTrack as! MusicFileTrack).location
        {
            let title = "\(operationIcon) \(trackName)"
            let subtitle: String
            if trackArtist != "", trackAlbum != "" {
                subtitle = "\(trackArtist) - \(trackAlbum)"
            } else if trackArtist == "", trackAlbum == "" {
                subtitle = ""
            } else {
                if trackArtist != "" {
                    subtitle = trackArtist
                } else {
                    subtitle = trackAlbum
                }
            }
            
            if let trackCover = Self.getCover(mp3path: mp3url) {
                // with cover
                PushNotificationWithNSImage(title: title, subtitle: subtitle, nsimage: trackCover)
            } else {
                // no cover
                PushNotification(title: title, subtitle: subtitle)
            }
        } else {
            print(Log().error + "no currentTrack")
        }
    }
    
    /// advance to the next track in the current playlist
    func nextTrack() {
        MusicApplication.nextTrack()
        // no notification because Music.app has its own notification
        // TODO: add a preference to let user close the notificatioins of Music.app and use the provided.
    }
    
    /// return to the previous track in the current playlist
    func previousTrack() {
        MusicApplication.previousTrack()
        // no notification because Music.app has its own notification
        // TODO: add a preference to let user close the notificatioins of Music.app and use the provided.
    }
    
    func volumeUp() {
        let newVolume: Int = ((soundVolume + 5) > 100) ? 100 : (soundVolume + 5)
        MusicApplication.setSoundVolume(newVolume)
        
        let volumeString: String = "􀊨 \(newVolume)%"
        
        PushNotification(title: volumeString)
    }
    
    func volumeDown() {
        let newVolume: Int = (soundVolume - 5 < 0) ? 0 : (soundVolume - 5)
        MusicApplication.setSoundVolume(newVolume)
        
        let volumeString: String = "􀊤 \(newVolume)%"
        
        PushNotification(title: volumeString)
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
