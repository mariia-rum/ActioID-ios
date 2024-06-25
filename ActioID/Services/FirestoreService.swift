import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    private let db = Firestore.firestore()

    func fetchNewsArticles(completion: @escaping ([NewsArticle]?) -> Void) {
        db.collection("newsArticles").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(nil)
            } else {
                let articles = snapshot?.documents.compactMap { document -> NewsArticle? in
                    try? document.data(as: NewsArticle.self)
                }
                completion(articles)
            }
        }
    }

    func addNewsArticle(_ article: NewsArticle, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection("newsArticles").addDocument(from: article)
            completion(true)
        } catch {
            print("Error adding document: \(error)")
            completion(false)
        }
    }
}
