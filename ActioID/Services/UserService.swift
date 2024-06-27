import FirebaseFirestore
import FirebaseFirestoreSwift

class UserService {
    private let firestoreService = FirestoreService()

    func fetchUserProfile(userId: String, completion: @escaping (UserProfile?) -> Void) {
        firestoreService.fetchDocuments(from: "users") { (users: [UserProfile]?) in
            completion(users?.first(where: { $0.id == userId }))
        }
    }

    func addUserProfile(_ profile: UserProfile, completion: @escaping (Bool) -> Void) {
        firestoreService.addDocument(profile, to: "users", completion: completion)
    }
}
