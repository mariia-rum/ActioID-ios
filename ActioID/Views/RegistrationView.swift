import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .customTextFieldStyle()
                .padding(.horizontal)
                .padding(.top, 30)
            
            SecureField("Password", text: $password)
                .customTextFieldStyle()
                .padding(.horizontal)
                .padding(.top, 10)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .customTextFieldStyle()
                .padding(.horizontal)
                .padding(.top, 10)
            
            Button("Register") {
                register()
            }
            .customButtonStyle()
            
            if showingAlert {
                Text(alertMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    private func register() {
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match"
            showingAlert = true
            return
        }
        
        AuthService().register(email: email, password: password) { success, error in
            if success {
                alertMessage = "Registration successful!"
            } else {
                alertMessage = error?.localizedDescription ?? "Registration failed"
            }
            showingAlert = true
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
