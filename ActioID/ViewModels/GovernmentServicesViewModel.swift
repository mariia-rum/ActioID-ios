import SwiftUI

// ViewModel
class GovernmentServicesViewModel: ObservableObject {
    @Published var services: [Service] = []

    func fetchServiceRequests() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.services = [
                Service(name: "RESIDENCE REGISTRATION", description: "This Section Of ActioID Helps You Manage Your Residence Registration In Germany. We'll Guide You Through The Process, Securely Transmit Your Information To The Bürgeramt, And Keep You Updated On The Status.", isExpanded: false, subServices: [
                    SubService(name: "Initial Registration"),
                    SubService(name: "Changes to Registration"),
                    SubService(name: "De-registration")
                ]),
                Service(name: "TAX-RELATED SERVICES", description: "Description for tax-related services", isExpanded: false, subServices: []),
            ]
        }
    }
}

struct Service: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var isExpanded: Bool
    let subServices: [SubService]
}

struct SubService: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

