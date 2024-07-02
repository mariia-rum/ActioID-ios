import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Document: Identifiable, Codable {
    @DocumentID var id: String?
    var type: String
    var photoUrl: String?
    var firstName: String
    var lastName: String
    var dateOfBirth: Timestamp?
    var passportNumber: String?
    var drivingLicenceNumber: String?
    var identificationNumber: String?
    var expiresOn: Timestamp?
    var issuedOn: Timestamp?
}
