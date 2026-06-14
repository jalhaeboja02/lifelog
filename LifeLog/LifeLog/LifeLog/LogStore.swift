import UIKit

struct LogEntry {
    let date: Date
    let image: UIImage
}

class LogStore {
    static let shared = LogStore()
    var logs: [LogEntry] = []
    
    func add(image: UIImage) {
        let entry = LogEntry(date: Date(), image: image)
        logs.append(entry)
    }
    
    func log(for date: Date) -> LogEntry? {
        return logs.first {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
    }
}
