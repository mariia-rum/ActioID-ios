import SwiftUI

struct GovernmentServicesView: View {
    @StateObject private var viewModel = GovernmentServicesViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.serviceRequests) { request in
                Text(request.type)
            }
            .navigationTitle("Government Services")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle service request
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchServiceRequests()
            }
        }
    }
}

struct GovernmentServicesView_Previews: PreviewProvider {
    static var previews: some View {
        GovernmentServicesView()
    }
}
