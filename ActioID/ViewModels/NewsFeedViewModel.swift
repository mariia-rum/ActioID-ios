import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    private var cancellables = Set<AnyCancellable>()
    private let newsService = NewsService()

    func fetchNews() {
        newsService.fetchNewsArticles { [weak self] articles in
            if let articles = articles {
                DispatchQueue.main.async {
                    self?.articles = articles
                }
            }
        }
    }
}
