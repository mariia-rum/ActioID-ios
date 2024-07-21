import Foundation
import FirebaseFirestore
import SwiftUI

extension Timestamp {
    func toFormattedString(format: String = "dd MMMM yyyy") -> String {
        let date = self.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let red, green, blue: Double
        switch hex.count {
        case 3: // RGB (12-bit)
            red = Double((int >> 8) * 17) / 255.0
            green = Double((int >> 4 & 0xF) * 17) / 255.0
            blue = Double((int & 0xF) * 17) / 255.0
        case 6: // RGB (24-bit)
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
        default:
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        self.init(red: red, green: green, blue: blue)
    }
}
