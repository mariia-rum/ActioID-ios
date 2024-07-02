import Foundation
import Combine

class DocumentManagementViewModel: ObservableObject {
    @Published var documents: [Document] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchDocuments() {
        DocumentService.shared.fetchDocuments { [weak self] documents in
            DispatchQueue.main.async {
                self?.documents = documents
            }
        }
    }

    func uploadDocument(document: Document) {
        DocumentService.shared.uploadDocument(document: document) { success in
            if success {
                self.fetchDocuments()
            }
        }
    }
}
