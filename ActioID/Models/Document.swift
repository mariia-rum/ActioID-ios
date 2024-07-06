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
    
    // Subcollection data
    var passport: [String: Any]?
    var drivingLicence: [String: Any]?
    var identificationNumber: [String: Any]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case firstName
        case lastName
        case dateOfBirth
        case photoUrl
    }
    
    init(id: String? = nil, userId: String, firstName: String, lastName: String, dateOfBirth: Timestamp? = nil, photoUrl: String? = nil, passport: [String: Any]? = nil, drivingLicence: [String: Any]? = nil, identificationNumber: [String: Any]? = nil) {
        self.id = id
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.photoUrl = photoUrl
        self.passport = passport
        self.drivingLicence = drivingLicence
        self.identificationNumber = identificationNumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        dateOfBirth = try container.decodeIfPresent(Timestamp.self, forKey: .dateOfBirth)
        photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encodeIfPresent(dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(photoUrl, forKey: .photoUrl)
    }
}

// Add this to support decoding [String: Any]
extension KeyedDecodingContainer {
    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try self.decode([String: AnyDecodable].self, forKey: key)
        return Dictionary(uniqueKeysWithValues: container.map { key, value in (key, value.value) })
    }
}

struct AnyDecodable: Decodable {
    var value: Any
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let nestedDict = try? container.decode([String: AnyDecodable].self) {
            value = nestedDict.mapValues { $0.value }
        } else if let nestedArray = try? container.decode([AnyDecodable].self) {
            value = nestedArray.map { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }
}
