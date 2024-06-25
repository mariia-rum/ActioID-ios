import SwiftUI

struct DocumentManagementView: View {
    @StateObject private var viewModel = DocumentManagementViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.documents) { document in
                Text(document.type)
            }
            .navigationTitle("Documents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle document upload
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchDocuments()
            }
        }
    }
}

struct DocumentManagementView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentManagementView()
    }
}
