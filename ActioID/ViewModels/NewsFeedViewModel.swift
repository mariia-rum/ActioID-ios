import Foundation
import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var articles: [NewsArticles] = []
    private var cancellables = Set<AnyCancellable>()
    private let newsService = NewsService()

    func fetchNews() {
        newsService.fetchNewsArticles { [weak self] articles in
            if let articles = articles {
                DispatchQueue.main.async {
                    self?.articles = articles
                    print("Fetched articles: \(articles)")
                    for article in articles {
                        print("Article: \(article.id ?? "No ID") - \(article.title)")
                    }
                }
            } else {
                print("Failed to fetch articles")
            }
        }
    }
}
