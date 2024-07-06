import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct DocumentCardView: View {
    let document: Document
    @State private var showQRCode = false
    @State private var imageURL: URL?
    @State private var qrCodeURL: URL?

    var body: some View {
        VStack {
            if showQRCode {
                VStack {
                    Text(documentType)
                        .font(.headline)
                        .padding()
                    if let qrCodeURL = qrCodeURL {
                        AsyncImage(url: qrCodeURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .padding(15)
                                .padding(.top, 5)
                                .padding(.bottom, 15)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        ProgressView()
                            .onAppear {
                                fetchQRCodeURL()
                            }
                    }
                }
            } else {
                VStack(alignment: .center, spacing: 10) {
                    Text(documentType)
                        .font(.headline)
                    if let imageURL = imageURL, documentType != "Identification Number" {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 330)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text("First Name: \(document.firstName)")
                    Text("Last Name: \(document.lastName)")
                    if documentType == "National Passport" {
                        if let passport = document.passport {
                            Text("Passport Number: \(passport["passportNumber"] as? String ?? "")")
                            Text("Issued On: \(formatDate(timestamp: passport["issuedOn"] as? Timestamp))")
                            Text("Expires On: \(formatDate(timestamp: passport["expiresOn"] as? Timestamp))")
                        }
                    } else if documentType == "Driving Licence" {
                        if let drivingLicence = document.drivingLicence {
                            Text("Driving Licence Number: \(drivingLicence["drivingLicenceNumber"] as? String ?? "")")
                            Text("Issued On: \(formatDate(timestamp: drivingLicence["issuedOn"] as? Timestamp))")
                            Text("Expires On: \(formatDate(timestamp: drivingLicence["expiresOn"] as? Timestamp))")
                        }
                    } else if documentType == "Identification Number" {
                        if let identificationNumber = document.identificationNumber {
                            Text("Identification Number: \(identificationNumber["identificationNumber"] as? String ?? "")")
                        }
                    }
                }
                .padding()
                .onAppear {
                    if documentType != "Identification Number" {
                        fetchImageURL()
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .onTapGesture {
            withAnimation {
                showQRCode.toggle()
            }
        }
    }

    private var documentType: String {
        if document.passport != nil {
            return "National Passport"
        } else if document.drivingLicence != nil {
            return "Driving Licence"
        } else if document.identificationNumber != nil {
            return "Identification Number"
        }
        return "Unknown Document"
    }

    private func formatDate(timestamp: Timestamp?) -> String {
        guard let timestamp = timestamp else { return "N/A" }
        return timestamp.toFormattedString()
    }

    private func fetchImageURL() {
        guard let photoUrl = document.photoUrl else { return }
        let storageRef = Storage.storage().reference(forURL: photoUrl)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error.localizedDescription)")
                return
            }
            self.imageURL = url
            print("Fetched image URL: \(url?.absoluteString ?? "No URL")")
        }
    }

    private func fetchQRCodeURL() {
        let qrCodePath = "gs://actioid-631ea.appspot.com/photosUsers/qr_code.png"
        let storageRef = Storage.storage().reference(forURL: qrCodePath)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching QR code URL: \(error.localizedDescription)")
                return
            }
            self.qrCodeURL = url
            print("Fetched QR code URL: \(url?.absoluteString ?? "No URL")")
        }
    }
}

struct DocumentCardView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentCardView(document: Document(id: UUID().uuidString, userId: "test1", firstName: "Erika", lastName: "Mustermann", dateOfBirth: nil, photoUrl: "gs://actioid-631ea.appspot.com/photosUsers/erika-mustermann.png", passport: ["passportNumber": "123456789", "issuedOn": Timestamp(date: Date()), "expiresOn": Timestamp(date: Date())], drivingLicence: ["drivingLicenceNumber": "987654321", "issuedOn": Timestamp(date: Date()), "expiresOn": Timestamp(date: Date())], identificationNumber: ["identificationNumber": "A1234567"]))
    }
}
