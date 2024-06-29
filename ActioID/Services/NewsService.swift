import FirebaseFirestore
import FirebaseFirestoreSwift

class NewsService {
    private let firestoreService = FirestoreService()

    func fetchNewsArticles(completion: @escaping ([NewsArticles]?) -> Void) {
        firestoreService.fetchDocuments(from: "newsArticles", completion: completion)
    }

    func addNewsArticle(_ article: NewsArticles, completion: @escaping (Bool) -> Void) {
        firestoreService.addDocument(article, to: "newsArticles", completion: completion)
    }
}
