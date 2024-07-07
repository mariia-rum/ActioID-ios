import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct DocumentCardView: View {
    let document: Document
    let subcollection: String
    @State private var showQRCode = false
    @State private var imageURL: URL?
    @State private var qrCodeURL: URL?

    var body: some View {
        VStack {
            if showQRCode {
                VStack {
                    Text(cardTitle)
                        .font(.headline)
                        .padding()
                    if let qrCodeURL = qrCodeURL {
                        AsyncImage(url: qrCodeURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .padding(15)
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
                    Text(cardTitle)
                        .font(.headline)
                    if subcollection == "passport" || subcollection == "drivingLicence" {
                        if let imageURL = imageURL {
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
                        } else {
                            ProgressView()
                                .frame(height: 150)
                                .cornerRadius(8)
                                .onAppear {
                                    fetchImageURL()
                                }
                        }
                    }
                    Text("First Name: \(document.firstName)")
                    Text("Last Name: \(document.lastName)")
                    if subcollection == "passport", let passport = document.passport {
                        Text("Passport Number: \(passport.passportNumber)")
                        Text("Issued On: \(passport.issuedOn.toFormattedString())")
                        Text("Expires On: \(passport.expiresOn.toFormattedString())")
                        if let dateOfBirth = document.dateOfBirth {
                            Text("Date of Birth: \(dateOfBirth.toFormattedString())")
                        }
                    }
                    if subcollection == "drivingLicence", let drivingLicence = document.drivingLicence {
                        Text("Driving Licence Number: \(drivingLicence.drivingLicenceNumber)")
                        Text("Issued On: \(drivingLicence.issuedOn.toFormattedString())")
                        Text("Expires On: \(drivingLicence.expiresOn.toFormattedString())")
                    }
                    if subcollection == "identificationNumber", let identificationNumber = document.identificationNumber {
                        Text("Identification Number: \(identificationNumber.identificationNumber)")
                    }
                }
                .padding()
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

    private var cardTitle: String {
        switch subcollection {
        case "passport":
            return "National Passport"
        case "drivingLicence":
            return "Driving Licence"
        case "identificationNumber":
            return "Identification Number"
        default:
            return ""
        }
    }

    private func fetchImageURL() {
        guard let photoUrl = document.photoUrl else {
            print("Photo URL is nil")
            return
        }
        let storageRef = Storage.storage().reference(forURL: photoUrl)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error.localizedDescription)")
                return
            }
            print("Fetched image URL: \(url?.absoluteString ?? "No URL")")
            self.imageURL = url
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
            print("Fetched QR code URL: \(url?.absoluteString ?? "No URL")")
            self.qrCodeURL = url
        }
    }
}
