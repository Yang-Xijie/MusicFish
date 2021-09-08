// Notification.swift

import Cocoa
import UserNotifications

func PushNotification(title: String, subtitle: String, body: String = "") {
    // Create the notification and setup information
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body

    // Create the request
    let request = UNNotificationRequest(
        identifier: "",
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
    if let attachment = UNNotificationAttachment.create(identifier: "title", image: nsimage, options: nil) {
        content.attachments.append(attachment)
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
        } else {
            // Successfully
            print(Log().string + "successfully pushed")
        }
    }
}
