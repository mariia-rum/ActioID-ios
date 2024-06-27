import FirebaseFirestore
import FirebaseFirestoreSwift

class NewsService {
    private let firestoreService = FirestoreService()

    func fetchNewsArticles(completion: @escaping ([NewsArticle]?) -> Void) {
        firestoreService.fetchDocuments(from: "newsArticles", completion: completion)
    }

    func addNewsArticle(_ article: NewsArticle, completion: @escaping (Bool) -> Void) {
        firestoreService.addDocument(article, to: "newsArticles", completion: completion)
    }
}
