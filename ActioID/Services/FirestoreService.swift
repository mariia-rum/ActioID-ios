import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    private let db = Firestore.firestore()

    func fetchDocuments<T: Decodable>(from collection: String, completion: @escaping ([T]?) -> Void) {
        db.collection(collection).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion(nil)
            } else {
                let documents = snapshot?.documents.compactMap { document -> T? in
                    try? document.data(as: T.self)
                }
                completion(documents)
            }
        }
    }

    func addDocument<T: Encodable>(_ document: T, to collection: String, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection(collection).addDocument(from: document)
            completion(true)
        } catch {
            print("Error adding document: \(error)")
            completion(false)
        }
    }
}
