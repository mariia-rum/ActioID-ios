import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @State private var searchText = ""

    var filteredArticles: [NewsArticles] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { article in
                article.title.lowercased().contains(searchText.lowercased()) ||
                article.description.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    Spacer().frame(height: 20)
                    Text("News")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 10)
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 10)
                        .frame(width: 370, height: 70)
                        .background(Color(.clear))
                }
                .padding(.horizontal, 20)
                
                List(filteredArticles) { article in
                    NavigationLink(destination: ArticleDetailsView(article: article)) {
                        HStack {
                            AsyncImage(url: URL(string: "https://www.bmj.de/SiteGlobals/Frontend/Images/logo-newsletter.jpg?__blob=normal")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .padding(.trailing, 8)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }

                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                Text(article.pubDate)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onAppear {
                        print("Displaying article: \(article.id ?? "No ID") - \(article.title)")
                    }
                }
                .background(Color(red: 0xED/255, green: 0xE6/255, blue: 0xD7/255).opacity(0.3)) // Lighter background color
            }
            .background(Color.white) // Background for the whole view
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchNews()
            }
        }
        .background(Color.white) // Ensure the navigation view has the correct background
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Articles"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage() // Remove background for custom styling
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
