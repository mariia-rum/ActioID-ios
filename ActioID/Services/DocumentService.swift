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
                        print("Document ID: \(documentId)")

                        dispatchGroup.enter()
                        self.fetchSubcollectionDocument(for: documentId, collection: "passport", type: Passport.self) { passport in
                            if let passport = passport {
                                doc.passport = passport
                                print("Assigned passport data for document ID \(documentId): \(passport)")
                            } else {
                                print("No passport data found for document ID \(documentId)")
                            }
                            dispatchGroup.leave()
                        }

                        dispatchGroup.enter()
                        self.fetchSubcollectionDocument(for: documentId, collection: "drivingLicence", type: DrivingLicence.self) { drivingLicence in
                            if let drivingLicence = drivingLicence {
                                doc.drivingLicence = drivingLicence
                                print("Assigned drivingLicence data for document ID \(documentId): \(drivingLicence)")
                            } else {
                                print("No drivingLicence data found for document ID \(documentId)")
                            }
                            dispatchGroup.leave()
                        }

                        dispatchGroup.enter()
                        self.fetchSubcollectionDocument(for: documentId, collection: "identificationNumber", type: IdentificationNumber.self) { identificationNumber in
                            if let identificationNumber = identificationNumber {
                                doc.identificationNumber = identificationNumber
                                print("Assigned identificationNumber data for document ID \(documentId): \(identificationNumber)")
                            } else {
                                print("No identificationNumber data found for document ID \(documentId)")
                            }
                            dispatchGroup.leave()
                        }
                        
                        dispatchGroup.notify(queue: .main) {
                            result.append(doc)
                            print("Updated document: \(doc)")
                        }
                    }
                } catch {
                    print("Error decoding document: \(error)")
                }
            }

            dispatchGroup.notify(queue: .main) {
                print("Completed fetching subcollections")
                print("Documents: \(result)")
                completion(result)
            }
        }
    }

    private func fetchSubcollectionDocument<T: Codable>(for documentId: String, collection: String, type: T.Type, completion: @escaping (T?) -> Void) {
        let collectionRef = db.collection("documents").document(documentId).collection(collection)
        print("Fetching subcollection from path: documents/\(documentId)/\(collection)")
        collectionRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, let document = documents.first else {
                print("Error fetching subcollection \(collection) for document ID \(documentId): \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            do {
                let data = try document.data(as: T.self)
                print("Fetched data from \(collection)/\(documentId): \(data)")
                completion(data)
            } catch {
                print("Error decoding subcollection document \(collection) for document ID \(documentId): \(error)")
                completion(nil)
            }
        }
    }
}
