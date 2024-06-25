import Foundation

struct UserProfile: Identifiable {
    let id: UUID
    var name: String
    var email: String
    var phone: String
}
