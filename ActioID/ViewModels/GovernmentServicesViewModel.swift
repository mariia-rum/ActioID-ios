import Foundation
import Combine

class GovernmentServicesViewModel: ObservableObject {
    @Published var services: [Service] = []

    func fetchServiceRequests() {
        // Simulate API call to fetch services
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.services = [
                Service(name: "RESIDENCE REGISTRATION", description: "This Section Of ActioID Helps You Manage Your Residence Registration In Germany. We'll Guide You Through The Process, Securely Transmit Your Information To The Bürgeramt, And Keep You Updated On The Status.", isExpanded: false, subServices: [
                    SubService(name: "Initial Registration"),
                    SubService(name: "Changes to Registration"),
                    SubService(name: "De-registration")
                ]),
                Service(name: "TAX-RELATED SERVICES", description: "Description for tax-related services", isExpanded: false, subServices: []),
                // Add more services as needed
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

struct SubService: Identifiable {
    let id = UUID()
    let name: String
}

struct ServiceRequest: Identifiable {
    let id = UUID()
    let type: String
}
