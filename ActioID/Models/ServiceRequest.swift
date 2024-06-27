import Foundation

struct ServiceRequest: Identifiable {
    let id: UUID
    let type: String
    let status: String
}
