import SwiftUI

struct DocumentManagementView: View {
    @StateObject private var viewModel = DocumentManagementViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.documents) { document in
                        if document.passport != nil {
                            DocumentCardView(document: document)
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if document.drivingLicence != nil {
                            DocumentCardView(document: document)
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if document.identificationNumber != nil {
                            DocumentCardView(document: document)
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                    }
                }
                .padding()
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
