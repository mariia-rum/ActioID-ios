import SwiftUI

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 25) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.black : Color.gray)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct DocumentManagementView: View {
    @StateObject private var viewModel = DocumentManagementViewModel()
    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                Text("Documents")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 50)
    
                
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.documents.indices, id: \.self) { index in
                        DocumentCardView(document: viewModel.documents[index], subcollection: "passport")
                            .frame(width: 350, height: 520)
                            .tag(index)
                        DocumentCardView(document: viewModel.documents[index], subcollection: "drivingLicence")
                            .frame(width: 350, height: 520)
                            .tag(index + viewModel.documents.count)
                        DocumentCardView(document: viewModel.documents[index], subcollection: "identificationNumber")
                            .frame(width: 350, height: 520)
                            .tag(index + 2 * viewModel.documents.count)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 550)
                .onChange(of: currentIndex) { oldValue, newValue in
                    withAnimation {
                        currentIndex = newValue
                    }
                }
                
                PageControl(numberOfPages: viewModel.documents.count * 3, currentPage: $currentIndex) 
                    .padding(.bottom, 20)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
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
