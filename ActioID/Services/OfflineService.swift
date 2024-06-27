import Foundation

class OfflineService {
    static let shared = OfflineService()

    func syncDocumentsForOffline(completion: @escaping (Bool) -> Void) {
        // Implement document synchronization for offline access
    }

    func getOfflineDocument(documentID: UUID, completion: @escaping (Document?) -> Void) {
        // Implement fetching of offline document
    }
}
