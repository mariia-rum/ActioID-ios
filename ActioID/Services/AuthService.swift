import FirebaseAuth
import SwiftUI

class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            self?.isAuthenticated = true
            completion(true)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func register(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
}
