import SwiftUI

struct AccountManagementView: View {
    var body: some View {
        // Main ZStack to control the background
        ZStack {
            Color.white // White background for the entire screen
                .edgesIgnoringSafeArea(.all) // Ensures the background covers the whole screen

            NavigationView {
                VStack {
                    Spacer().frame(height: 10)
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                    Spacer().frame(height: 10)

                    ZStack {
                        Color.white // Ensures the Form's background is white

                        Form {
                            Group {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .foregroundColor(Color(hexString: "#00008B"))
                                            .frame(width: 100, height: 100, alignment: .center)
                                        Text("Erika Mustermann")
                                            .font(.title)
                                        Text(attributedString("erikamustermann@gmail.com"))
                                            .font(.subheadline)
                                            .foregroundColor(Color(hexString: "#00008B"))
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                            .listRowBackground(Color.white)

                            Section(header: Text("CONTENT")) {
                                NavigationLink(destination: MessagesView()) {
                                    HStack {
                                        Image(systemName: "envelope")
                                        Text("Messages")
                                    }
                                }
                            }
                            .listRowBackground(Color.white)

                            Section(header: Text("PREFERENCES")) {
                                NavigationLink(destination: SettingsView()) {
                                    HStack {
                                        Image(systemName: "gear")
                                        Text("Settings")
                                    }
                                }

                                NavigationLink(destination: CustomerSupportView()) {
                                    HStack {
                                        Image(systemName: "headphones")
                                        Text("Customer Support")
                                    }
                                }

                                NavigationLink(destination: FAQView()) {
                                    HStack {
                                        Image(systemName: "questionmark.circle")
                                        Text("FAQ")
                                    }
                                }
                            }
                            .listRowBackground(Color.white)

                            Section {
                                Button(action: {
                                    print("Logout tapped")
                                }) {
                                    Text("Logout")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .font(.system(size: 18))
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color(hexString: "#00008B"))
                                        .cornerRadius(25)
                                }
                            }
                            .listRowBackground(Color.white)
                        }
                        .scrollContentBackground(.hidden) // Hides the default background
                    }
                    .background(Color.white)
                }
                .background(Color.white)
            }
            .background(Color.white)
        } // End of ZStack
    }

    private func attributedString(_ string: String) -> AttributedString {
        var attributedString = AttributedString(string)
        attributedString.foregroundColor = Color(hexString: "#00008B")
        return attributedString
    }
}

// Extension to support hex color
extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 17) & 0xF0, (int >> 4 & 0xF0), int & 0xF0)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct AccountManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AccountManagementView()
    }
}
