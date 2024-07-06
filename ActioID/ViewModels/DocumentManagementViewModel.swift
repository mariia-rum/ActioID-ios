import Foundation

class DocumentManagementViewModel: ObservableObject {
    @Published var documents: [Document] = []
    
    func fetchDocuments() {
        // Assuming userId is available in your app
        let userId = "test1"
        DocumentService.shared.fetchDocuments(for: userId) { documents in
            DispatchQueue.main.async {
                self.documents = documents
            }
        }
    }
}
