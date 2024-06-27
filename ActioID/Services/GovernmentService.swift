import Foundation

class GovernmentService {
    static let shared = GovernmentService()

    func fetchServiceRequests(completion: @escaping ([ServiceRequest]) -> Void) {
        // Implement API call to fetch service requests
    }

    func requestService(request: ServiceRequest, completion: @escaping (Bool) -> Void) {
        // Implement API call to request service
    }
}
