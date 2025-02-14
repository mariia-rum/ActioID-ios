import Foundation

class AccountManagementViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile(id: nil, name: "", email: "", phone: "")

    func updateProfile() {
        // Handle profile update
    }

    func updateNotificationSettings() {
        // Handle notification settings update
    }

    func enableOfflineAccess() {
        // Handle enabling offline access
    }
}
