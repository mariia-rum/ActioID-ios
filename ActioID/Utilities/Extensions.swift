import Foundation
import FirebaseFirestore

extension Timestamp {
    func toFormattedString(format: String = "dd MMMM yyyy") -> String {
        let date = self.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
