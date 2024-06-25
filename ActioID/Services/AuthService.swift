import Foundation

class AuthService {
    static let shared = AuthService()

    func sendOTP(email: String, phone: String, completion: @escaping (Bool) -> Void) {
        // Implement API call to send OTP
    }

    func verifyOTP(otp: String, completion: @escaping (Bool) -> Void) {
        // Implement API call to verify OTP
    }

    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Implement API call to register user
    }
}
