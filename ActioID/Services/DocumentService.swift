import Foundation

class DocumentService {
    static let shared = DocumentService()

    func fetchDocuments(completion: @escaping ([Document]) -> Void) {
        // Implement API call to fetch documents
    }

    func uploadDocument(document: Document, completion: @escaping (Bool) -> Void) {
        // Implement API call to upload document
    }
}
