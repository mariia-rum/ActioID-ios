import SwiftUI

struct DocumentManagementView: View {
    @StateObject private var viewModel = DocumentManagementViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.documents) { document in
                        if let passport = document.passport {
                            DocumentCardView(document: document, subcollection: "passport")
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if let drivingLicence = document.drivingLicence {
                            DocumentCardView(document: document, subcollection: "drivingLicence")
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                        if let identificationNumber = document.identificationNumber {
                            DocumentCardView(document: document, subcollection: "identificationNumber")
                                .frame(width: UIScreen.main.bounds.width - 40)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Documents")
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
