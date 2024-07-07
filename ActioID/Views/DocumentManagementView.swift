import SwiftUI

struct DocumentManagementView: View {
    @StateObject private var viewModel = DocumentManagementViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.documents) { document in
                        if let _ = document.passport {
                            DocumentCardView(document: document, subcollection: "passport")
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if let _ = document.drivingLicence {
                            DocumentCardView(document: document, subcollection: "drivingLicence")
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if let _ = document.identificationNumber {
                            DocumentCardView(document: document, subcollection: "identificationNumber")
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
