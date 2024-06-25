import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NewsFeedView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            DocumentManagementView()
                .tabItem {
                    Label("Documents", systemImage: "doc.text")
                }

            GovernmentServicesView()
                .tabItem {
                    Label("Services", systemImage: "building.2")
                }

            AccountManagementView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
