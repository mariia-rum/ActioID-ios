import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct NewsArticles: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var link: String
    var pubDate: String
    var description: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
        case pubDate
        case description
    }

    init(id: String? = nil, title: String, link: String, pubDate: String, description: String) {
        self.id = id ?? UUID().uuidString
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        if let timestamp = try container.decodeIfPresent(Timestamp.self, forKey: .pubDate) {
            pubDate = timestamp.dateValue().toString(format: "MMM dd, yyyy HH:mm:ss")
        } else {
            pubDate = try container.decode(String.self, forKey: .pubDate)
        }
        description = try container.decode(String.self, forKey: .description)
    }
}
