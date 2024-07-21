import FirebaseAuth
import LocalAuthentication
import SwiftUI

class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?

    private let passcodeAccount = "userPasscode"
    
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

    func savePasscode(_ passcode: String) {
        KeychainHelper.shared.savePasscode(passcode, account: passcodeAccount)
    }
    
    func authenticateWithPasscode(_ passcode: String) -> Bool {
        guard let storedPasscode = KeychainHelper.shared.getPasscode(account: passcodeAccount) else {
            return false
        }
        if storedPasscode == passcode {
            self.isAuthenticated = true
            return true
        } else {
            self.errorMessage = "Invalid passcode"
            return false
        }
    }

    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your account"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        completion(true)
                    } else {
                        self.errorMessage = authenticationError?.localizedDescription
                        completion(false)
                    }
                }
            }
        } else {
            self.errorMessage = "Biometric authentication is not available"
            completion(false)
        }
    }
}
