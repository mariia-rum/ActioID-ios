import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let red, green, blue: Double
        switch hex.count {
        case 3: // RGB (12-bit)
            red = Double((int >> 8) * 17) / 255.0
            green = Double((int >> 4 & 0xF) * 17) / 255.0
            blue = Double((int & 0xF) * 17) / 255.0
        case 6: // RGB (24-bit)
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
        default:
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        self.init(red: red, green: green, blue: blue)
    }
}

enum Tab: String, CaseIterable {
    case home
    case documents
    case services
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .documents: return "Documents"
        case .services: return "Services"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .documents: return "doc"
        case .services: return "square.grid.2x2"
        case .profile: return "person"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    private let selectedTabColor = Color(hex: "#00008B") // Custom color

    private var fillImage: String {
        selectedTab.icon + ".fill"
    }

    var body: some View {
        VStack {
            // Main content based on selected tab
            switch selectedTab {
            case .home:
                NewsFeedView()
            case .documents:
                DocumentManagementView()
            case .services:
                GovernmentServicesView()
            case .profile:
                AccountManagementView()
            }
            
            // Custom Tab Bar
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == tab && tab != .home ? fillImage : tab.icon)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 25)
                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                            .foregroundColor(selectedTab == tab ? selectedTabColor : .gray)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
                        Text(tab.title)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
            .frame(height: 70)
            .padding(.bottom, 9)
            //.background(.thinMaterial)
            //.cornerRadius(10)
            //..padding(.horizontal)
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
