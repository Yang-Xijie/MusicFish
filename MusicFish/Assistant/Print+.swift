import Foundation

// Literal        Type     Value
//
// #file          String   The name of the file in which it appears.
// #line          Int      The line number on which it appears.
// #column        Int      The column number in which it begins.
// #function      String   The name of the declaration in which it appears.

// example:
// [\((#file as NSString).lastPathComponent) \(#function) line\(#line)]

/// use `Log()` to generate head of log easily in `Swift.print()`
///
/// To create a `code snippet`:
///
/// 1. Select: print(Log().string + "<\hashinfo\hash>")
///
/// 2. Go to `Xcode -> Editor -> Create Code Snippet`.
///
/// 3. Change `\hash` to `#`.
///
/// 4. Set title as `Log()` and `completion` as `print`.
///
/// Type `print` and select the code snippet.
struct Log: CustomStringConvertible {
    public var log_short: String
    public var log_medium: String
    public var log_long: String

    public var time_short: String
    public var time_medium: String
    public var time_long: String

    init(filePath: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        let fileName = (filePath as NSString).lastPathComponent

        let formatter = DateFormatter()
        // short: Specifies a short style, typically numeric only, such as “11/23/37” or “3:30 PM”.
        // medium: Specifies a medium style, typically with abbreviated text, such as “Nov 23, 1937” or “3:30:32 PM”.
        // long: Specifies a long style, typically with full text, such as “November 23, 1937” or “3:30:32 PM PST”.
        // full: Specifies a full style with complete details, such as “Tuesday, April 12, 1952 AD” or “3:30:42 PM Pacific Standard Time”.
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        time_short = formatter.string(from: Date())

        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        time_medium = formatter.string(from: Date())

        formatter.dateStyle = .short
        formatter.timeStyle = .long
        time_long = formatter.string(from: Date())

        log_short = "\(fileName)(\(line))"
        log_medium = "\(fileName)(\(line)) \(funcName)"
        log_long = "\(filePath)(\(line),\(column)) \(funcName)"
    }

    public var description: String {
        return "[\(time_medium) \(log_medium)]\n\t"
    }

    public var string: String {
        description
    }

    public var debug: String {
        "[[DEBUG]] " + description
    }

    public var error: String {
        "[[ERROR]] " + description
    }

    public var fatalerror: String {
        "[FATAL ERROR] " + description
    }
}
