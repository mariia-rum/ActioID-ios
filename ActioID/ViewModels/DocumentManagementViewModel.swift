import Foundation
import Combine

class DocumentManagementViewModel: ObservableObject {
    @Published var documents: [Document] = []
    private var cancellables = Set<AnyCancellable>()
    private let documentService = DocumentService()

    func fetchDocuments() {
        let userId = "test1" // Replace with actual user ID
        documentService.fetchDocuments(for: userId) { [weak self] documents in
            DispatchQueue.main.async {
                self?.documents = documents
                print("Fetched documents: \(documents)")
                for doc in documents {
                    print("Document: \(doc)")
                }
            }
        }
    }
}
