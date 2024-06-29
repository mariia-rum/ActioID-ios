import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    private let db = Firestore.firestore()

    func fetchDocuments<T: Decodable>(from collection: String, completion: @escaping ([T]?) -> Void) {
        db.collection(collection).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                completion(nil)
            } else {
                let documents = snapshot?.documents.compactMap { document -> T? in
                    do {
                        let data = try document.data(as: T.self)
                        print("Fetched document data: \(data)")
                        return data
                    } catch {
                        print("Error decoding document: \(error.localizedDescription)")
                        return nil
                    }
                }
                print("Documents fetched: \(documents?.count ?? 0)")
                completion(documents)
            }
        }
    }

    func addDocument<T: Encodable>(_ document: T, to collection: String, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection(collection).addDocument(from: document)
            completion(true)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
            completion(false)
        }
    }
}
