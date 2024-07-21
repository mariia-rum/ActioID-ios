import SwiftUI
import FirebaseAuth

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
    @StateObject private var viewModel = AuthViewModel()
    @State private var selectedTab: Tab = .home
    private let selectedTabColor = Color(hex: "#00008B")

    private var fillImage: String {
        selectedTab.icon + ".fill"
    }

    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                VStack {
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
                }
                .edgesIgnoringSafeArea(.bottom)
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.isAuthenticated = Auth.auth().currentUser != nil
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
