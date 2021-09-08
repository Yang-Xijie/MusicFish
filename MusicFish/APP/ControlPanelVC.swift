// ControlTabVC.swift

import Cocoa
import KeyboardShortcuts

class ControlPanelVC: NSViewController {
    // Custom View in Storyboard
    @IBOutlet var playpauseShortcut: NSView!
    @IBOutlet var previousTrackShortcut: NSView!
    @IBOutlet var nextTrackShortcut: NSView!

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
    }
}
