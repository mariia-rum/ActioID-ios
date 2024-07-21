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
                                            .foregroundColor(Color(hex: "#00008B"))
                                            .frame(width: 100, height: 100, alignment: .center)
                                        Text("Erika Mustermann")
                                            .font(.title)
                                        Text(attributedString("erikamustermann@gmail.com"))
                                            .font(.subheadline)
                                            .foregroundColor(Color(hex: "#00008B"))
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
                                        .background(Color(hex: "#00008B"))
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
        attributedString.foregroundColor = Color(hex: "#00008B")
        return attributedString
    }
}

struct AccountManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AccountManagementView()
    }
}

