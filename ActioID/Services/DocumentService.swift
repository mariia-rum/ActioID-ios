import Foundation
import FirebaseFirestore

class DocumentService {
    static let shared = DocumentService()
    private let db = Firestore.firestore()

    func fetchDocuments(completion: @escaping ([Document]) -> Void) {
        db.collection("documents").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
                return
            }

            let documents = snapshot?.documents.compactMap { document -> Document? in
                try? document.data(as: Document.self)
            } ?? []
            completion(documents)
        }
    }

    func uploadDocument(document: Document, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection("documents").addDocument(from: document)
            completion(true)
        } catch {
            print("Error uploading document: \(error)")
            completion(false)
        }
    }
}
