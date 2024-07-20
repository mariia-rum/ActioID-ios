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
            ZStack {
                if showQRCode {
                    qrCodeView
                        .rotation3DEffect(.degrees(showQRCode ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(showQRCode ? 1 : 0)
                } else {
                    cardContentView
                        .rotation3DEffect(.degrees(showQRCode ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(showQRCode ? 0 : 1)
                }
            }
            .frame(width: 350, height: 520)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) { // Increased animation duration
                    showQRCode.toggle()
                }
            }
        }
    }

    private var qrCodeView: some View {
        VStack {
            Text(cardTitle)
                .font(.title2)
                .bold()
                .padding()
               
            if let qrCodeURL = qrCodeURL {
                AsyncImage(url: qrCodeURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
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
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // Correct text orientation
    }

    private var cardContentView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(cardTitle)
                .font(.title2)
                .bold()
                .padding(.top,15)
                .padding(.bottom,10)
            if subcollection == "passport" || subcollection == "drivingLicence" {
                if let imageURL = imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
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
        .font(.callout)
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
            return
        }
        let storageRef = Storage.storage().reference(forURL: photoUrl)
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error.localizedDescription)")
                return
            }
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
            self.qrCodeURL = url
        }
    }
}
