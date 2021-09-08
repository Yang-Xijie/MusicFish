// ControlTabVC.swift

import AVKit
import Cocoa
import KeyboardShortcuts

class ControlPanelVC: NSViewController {
    // Custom View in Storyboard
    @IBOutlet var previousTrackShortcut: NSView!
    @IBOutlet var playpauseShortcut: NSView!
    @IBOutlet var nextTrackShortcut: NSView!

    @IBOutlet var volumeDownShortcut: NSView!
    @IBOutlet var volumeUpShortcut: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let previousTrackRecoder = KeyboardShortcuts.RecorderCocoa(for: .previousTrack)
        previousTrackShortcut.addSubview(previousTrackRecoder)
        previousTrackShortcut.setFrameSize(previousTrackRecoder.fittingSize)

        let playpauseRecoder = KeyboardShortcuts.RecorderCocoa(for: .playpause)
        playpauseShortcut.addSubview(playpauseRecoder)
        playpauseShortcut.setFrameSize(playpauseRecoder.fittingSize)

        let nextTrackRecoder = KeyboardShortcuts.RecorderCocoa(for: .nextTrack)
        nextTrackShortcut.addSubview(nextTrackRecoder)
        nextTrackShortcut.setFrameSize(nextTrackRecoder.fittingSize)

        let volumeUpRecoder = KeyboardShortcuts.RecorderCocoa(for: .volumeUp)
        volumeUpShortcut.addSubview(volumeUpRecoder)
        volumeUpShortcut.setFrameSize(volumeUpRecoder.fittingSize)

        let volumeDownRecoder = KeyboardShortcuts.RecorderCocoa(for: .volumeDown)
        volumeDownShortcut.addSubview(volumeDownRecoder)
        volumeDownShortcut.setFrameSize(volumeDownRecoder.fittingSize)
    }
}
