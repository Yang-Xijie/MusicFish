// Notification.swift

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
            let imageFileIdentifier = identifier + ".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            let imageData = image.pngData
            try imageData?.write(to: fileURL)
            let imageAttachment = try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print(Log().error + error.localizedDescription)
        }
        return nil
    }
}

func PushNotification(title: String, subtitle: String, body: String = "") {
    // Create the notification and setup information
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body

    // Create the request
    let uuidString = UUID().uuidString // TODO: not clear
    let request = UNNotificationRequest(
        identifier: uuidString,
        content: content,
        trigger: .none)

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { error in
        if error != nil {
            print(Log().error)
        } else {
            // Successfully
            print(Log().string + "successfully pushed")
        }
    }
}


func PushNotificationWithNSImage(title: String, subtitle: String, body: String = "", nsimage: NSImage) {
    // Create the notification and setup information
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body

    // identifier: If you specify an empty string, this method creates a unique identifier string for you.
    if let attachment = UNNotificationAttachment.create(identifier: "image", image: nsimage, options: nil) {
        content.attachments.append(attachment)
        print(Log().string + "added attachment")
    } else { return }

    // Create the request

    let request = UNNotificationRequest(
        identifier: "",
        content: content,
        trigger: .none)

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { error in
        if error != nil {
            print(Log().error + "\(error!)")
            // https://developer.apple.com/documentation/usernotifications/unerror/2325676-attachmentmoveintodatastorefaile
        } else {
            // Successfully
            print(Log().string + "successfully pushed")
        }
    }
}
