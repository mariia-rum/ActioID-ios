import Foundation

struct Document: Identifiable {
    let id: UUID
    let type: String
    let data: Data
}
