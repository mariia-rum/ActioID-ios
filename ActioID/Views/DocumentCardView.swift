import SwiftUI

struct DocumentCardView: View {
    let document: Document
    @State private var showQRCode = false

    var body: some View {
        VStack {
            if showQRCode {
                AsyncImage(url: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.investopedia.com%2Fterms%2Fq%2Fquick-response-qr-code.asp&psig=AOvVaw1BXbptwEUnqktGuB6RZrAy&ust=1719930809762000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKDBotmHhocDFQAAAAAdAAAAABAE")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Type: \(document.type)")
                        .font(.headline)
                    if let photoUrl = document.photoUrl {
                        AsyncImage(url: URL(string: photoUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text("First Name: \(document.firstName)")
                    Text("Last Name: \(document.lastName)")
                    if let passportNumber = document.passportNumber {
                        Text("Passport Number: \(passportNumber)")
                    }
                    if let drivingLicenceNumber = document.drivingLicenceNumber {
                        Text("Driving Licence Number: \(drivingLicenceNumber)")
                    }
                    if let identificationNumber = document.identificationNumber {
                        Text("Identification Number: \(identificationNumber)")
                    }
                    if let expiresOn = document.expiresOn {
                        Text("Expires On: \(expiresOn.toFormattedString(format: "dd MMMM yyyy"))")
                    }
                    if let issuedOn = document.issuedOn {
                        Text("Issued On: \(issuedOn.toFormattedString(format: "dd MMMM yyyy"))")
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
}

struct DocumentCardView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentCardView(document: Document(id: UUID().uuidString, type: "National Passport", photoUrl: nil, firstName: "Erika", lastName: "Mustermann", dateOfBirth: nil, passportNumber: "123456789", drivingLicenceNumber: nil, identificationNumber: nil, expiresOn: nil, issuedOn: nil))
    }
}
