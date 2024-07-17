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
                Service(name: "TAX-RELATED SERVICES", description: "File your taxes and access necessary forms.",isExpanded: false,
                    subServices: [
                    SubService(name: "Income Tax Declaration"),
                    SubService(name: "Tax Number Application")
                ]),
                Service(name: "VEHICLE REGISTRATION", description: "Register your vehicle, transfer ownership, and handle license plates.", isExpanded: false,
                    subServices: [
                    SubService(name: "New Vehicle Registration"),
                    SubService(name: "Used Vehicle Transfer"),
                    SubService(name: "Vehicle De-registration")
                    ]),
                Service(name: "ID&PASSPORT SERVICES", description: "Apply for or renew your ID cards and passports.", isExpanded: false,
                    subServices: [
                    SubService(name: "German ID Card Application"),
                    SubService(name: "German Passport Application"),
                    SubService(name: "Child's ID/Passport")
                    ]),
                Service(name: "BENEFITS APPLICATIONS", description: "Access information and apply for various social benefits in Germany.", isExpanded: false,
                    subServices: [
                    SubService(name: "Unemployment Benefits"),
                    SubService(name: "Child Benefits"),
                    SubService(name: "Housing Benefits")
                    ]),
                Service(name: "SOCIAL SECURITY", description: "Understand and manage your social security contributions.", isExpanded: false,
                    subServices: [
                    SubService(name: "Social Security Number"),
                    SubService(name: "Contributions Overview"),
                    SubService(name: "Pension Information")
                    ]),
                Service(name: "SURVEYS", description: "Participate in surveys and provide feedback to help shape government policies and services.", isExpanded: false,
                    subServices: [
                    SubService(name: "Curent Survey")
                    ]),
            ]
        }
    }

    func collapseAllServices() {
        for index in services.indices {
            services[index].isExpanded = false
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
