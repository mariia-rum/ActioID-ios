import SwiftUI

struct AccountManagementView: View {
    @StateObject private var viewModel = AccountManagementViewModel()

    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.userProfile.name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Email", text: $viewModel.userProfile.email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Phone", text: $viewModel.userProfile.phone)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                viewModel.updateProfile()
            }) {
                Text("Update Profile")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Account Management")
    }
}

struct AccountManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AccountManagementView()
    }
}
