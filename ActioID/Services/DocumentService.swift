import Foundation
import FirebaseFirestore

class DocumentService {
    static let shared = DocumentService()

    private let db = Firestore.firestore()

    func fetchDocuments(for userId: String, completion: @escaping ([Document]) -> Void) {
        db.collection("documents").whereField("userId", isEqualTo: userId).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            var result = [Document]()
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                do {
                    var doc = try document.data(as: Document.self)
                    if let documentId = doc.id {
                        dispatchGroup.enter()
                        self.fetchSubcollection(for: documentId, collection: "passport") { data in
                            doc.passport = data
                            dispatchGroup.leave()
                        }
                        
                        dispatchGroup.enter()
                        self.fetchSubcollection(for: documentId, collection: "drivingLicence") { data in
                            doc.drivingLicence = data
                            dispatchGroup.leave()
                        }
                        
                        dispatchGroup.enter()
                        self.fetchSubcollection(for: documentId, collection: "identificationNumber") { data in
                            doc.identificationNumber = data
                            dispatchGroup.leave()
                        }
                    }
                    result.append(doc)
                } catch {
                    print("Error decoding document: \(error)")
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(result)
            }
        }
    }

    private func fetchSubcollection(for documentId: String, collection: String, completion: @escaping ([String: Any]?) -> Void) {
        db.collection("documents").document(documentId).collection(collection).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, let document = documents.first else {
                print("Error fetching subcollection \(collection): \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            completion(document.data())
        }
    }
}
