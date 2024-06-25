import Foundation

class NewsService {
    static let shared = NewsService()

    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        // Implement API call to fetch articles
    }
}
