// Notification+.swift

import Cocoa
import UserNotifications

extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}

extension NSImage {
    var pngData: Data? { tiffRepresentation?.bitmap?.png }
}

extension UNNotificationAttachment {
    static func create(identifier: String, image: NSImage, options: [NSObject: AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            print(Log().string + "\(tmpSubFolderURL)")
            let imageFileIdentifier: String
            if identifier == "" {
                imageFileIdentifier = UUID().uuidString + ".png"
            } else {
                imageFileIdentifier = identifier + ".png"
            }
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            let imageData = image.pngData
            try imageData?.write(to: fileURL) // FIXME: may generate redundent files
            let imageAttachment = try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print(Log().error + error.localizedDescription)
        }
        return nil
    }
}
