import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Document: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Timestamp?
    var photoUrl: String?

    var passport: Passport?
    var drivingLicence: DrivingLicence?
    var identificationNumber: IdentificationNumber?

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case firstName
        case lastName
        case dateOfBirth
        case photoUrl
        case passport
        case drivingLicence
        case identificationNumber
    }
}

struct Passport: Identifiable, Codable {
    @DocumentID var id: String?
    var passportNumber: String
    var issuedOn: Timestamp
    var expiresOn: Timestamp
}

struct DrivingLicence: Identifiable, Codable {
    @DocumentID var id: String?
    var drivingLicenceNumber: String
    var issuedOn: Timestamp
    var expiresOn: Timestamp
}

struct IdentificationNumber: Identifiable, Codable {
    @DocumentID var id: String?
    var identificationNumber: String
}
