// MusicController.swift

import Cocoa
import ScriptingBridge

class MusicController {
    static let shared = MusicController()
    
    let MusicApplication: AnyObject
    
    init() {
        MusicApplication = SBApplication(bundleIdentifier: "com.apple.Music")!
    }

    var currentTrack:MusicTrack? {
        MusicApplication.currentTrack
    }
    
    func playpause() {
        // toggle the playing/paused state of the current track
        MusicApplication.playpause()
        
        if let currentTrack = MusicApplication.currentTrack,
           let trackName = currentTrack.name?.description,
           let trackArtist = currentTrack.artist?.description,
           let trackAlbum = currentTrack.album?.description
        {
            PushNotification(title: trackName, subtitle: "\(trackArtist) - \(trackAlbum)")
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
}
