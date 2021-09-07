// MusicController.swift

import Cocoa
import ScriptingBridge

class MusicController {
    static let shared = MusicController()
    
    let MusicApplication: AnyObject
    
    init() {
        MusicApplication = SBApplication(bundleIdentifier: "com.apple.Music")!
    }
    
    func playpause() {
        // toggle the playing/paused state of the current track
        MusicApplication.playpause()
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
