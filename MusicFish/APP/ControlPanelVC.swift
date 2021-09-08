// ControlTabVC.swift

import AVKit
import Cocoa
import KeyboardShortcuts

extension NSImage {
    convenience init(color: NSColor, size: NSSize) {
        self.init(size: size)
        lockFocus()
        color.drawSwatch(in: NSRect(origin: .zero, size: size))
        unlockFocus()
    }
}

class ControlPanelVC: NSViewController {
    // Custom View in Storyboard
    @IBOutlet var playpauseShortcut: NSView!
    @IBOutlet var previousTrackShortcut: NSView!
    @IBOutlet var nextTrackShortcut: NSView!

    @IBOutlet var TestImageView: NSImageView!
    @IBAction func ButtonClick(_ sender: Any) {
        print(Log().string + "button clicked")
        TestImageView.image = NSImage(color: .orange, size: NSSize(width: 128, height: 128))
//        TestImageView.image = getCover(filepath: URL(string: "/Users/yangxijie/yxj/MUSIC/iTunes/iTunes Media/Music/n-buna_GUMI/月を歩いている/2-01 花降らし AcousticPop Arrange..mp3")!)
        print(MusicController.shared.currentTrack)
        print((MusicController.shared.currentTrack! as! MusicFileTrack).location)
        if let path = (MusicController.shared.currentTrack! as! MusicFileTrack).location {
            TestImageView.image = getCover(filepath: path)
        }
    }

    func getCover(filepath: URL) -> NSImage {
        var artwork = NSImage(color: .orange, size: NSSize(width: 128, height: 128))

        let metadata = AVURLAsset(url: filepath).commonMetadata
        let artworkItems = AVMetadataItem.metadataItems(from: metadata, filteredByIdentifier: AVMetadataIdentifier.commonIdentifierArtwork)

        if let artworkItem = artworkItems.first {
            if let imageData = artworkItem.dataValue {
                artwork = NSImage(data: imageData) ?? NSImage(color: .orange, size: NSSize(width: 128, height: 128))
                artwork.size = NSSize(width: 216, height: 216)
            }
        }

        return artwork
    }

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
