// RatingPanelVC.swift

import Cocoa
import KeyboardShortcuts

class RatingPanelVC: NSViewController {
    // Custom View in Storyboard
    @IBOutlet var loveShortcut: NSView!
    @IBOutlet var noEvaluationShortcut: NSView!
    @IBOutlet var dislikeShortcut: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loveRecoder = KeyboardShortcuts.RecorderCocoa(for: .love)
        loveShortcut.addSubview(loveRecoder)
        loveShortcut.setFrameSize(loveRecoder.fittingSize)

        let dislikeRecoder = KeyboardShortcuts.RecorderCocoa(for: .dislike)
        dislikeShortcut.addSubview(dislikeRecoder)
        dislikeShortcut.setFrameSize(dislikeRecoder.fittingSize)

        let noEvaluationRecoder = KeyboardShortcuts.RecorderCocoa(for: .noEvaluation)
        noEvaluationShortcut.addSubview(noEvaluationRecoder)
        noEvaluationShortcut.setFrameSize(noEvaluationRecoder.fittingSize)
    }
}
