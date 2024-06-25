import Foundation
import FirebaseFirestoreSwift

struct NewsArticle: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var link: String
    var pubDate: String
    var description: String
}
