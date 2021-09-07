// ControlTabVC.swift

import Cocoa
import KeyboardShortcuts

class ControlPanelVC: NSViewController {
    @IBOutlet var playpauseShortcut: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recorder = KeyboardShortcuts.RecorderCocoa(for: .playpause)
        playpauseShortcut.addSubview(recorder)
    }
}