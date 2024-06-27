import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var otp: String = ""
    @Published var password: String = ""
    @Published var isOTPVerified: Bool = false

    func sendOTP() {
        // Handle OTP sending logic
    }

    func verifyOTP() {
        // Handle OTP verification logic
        isOTPVerified = true
    }

    func register() {
        // Handle user registration and biometric setup
    }
}
