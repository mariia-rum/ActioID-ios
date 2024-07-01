import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel = NewsFeedViewModel()
    @State private var searchText = ""

    var filteredArticles: [NewsArticles] {
        searchText.isEmpty ? viewModel.articles : viewModel.articles.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.description.lowercased().contains(searchText.lowercased())
        }
    }

    private let lightBackgroundColor = Color(red: 0xED/255, green: 0xE6/255, blue: 0xD7/255).opacity(0.2) // Predefined color

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    Spacer().frame(height: 50)
                    Text("News")
                        .font(.largeTitle).bold()
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 20)
                        .frame(height: 60)
                        .background(Color(.clear))
                }
                .padding(.horizontal, 20)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(filteredArticles) { article in
                            NavigationLink(destination: ArticleDetailsView(article: article)) {
                                ArticleRow(article: article)
                                    .background(lightBackgroundColor)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .background(lightBackgroundColor)
                }
            }
            .background(Color.white)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchNews()
            }
        }
        .background(Color.white)
    }
}

struct ArticleRow: View {
    let article: NewsArticles

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: "https://www.bmj.de/SiteGlobals/Frontend/Images/logo-newsletter.jpg?__blob=normal")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    .padding(4)
                    .padding(.top, 4)
            } placeholder: {
                ProgressView().frame(width: 50, height: 50)
            }

            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .padding(.top, 4)
                    .multilineTextAlignment(.leading)
                    .frame(width: 330, alignment: .leading)
                    .lineLimit(nil)

                Text(article.pubDate)
                    .font(.subheadline)
                    .frame(height: 30, alignment: .leading)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .onAppear {
            print("Displaying article: \(article.id ?? "No ID") - \(article.title)")
        }
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
        searchBar.backgroundImage = UIImage()
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
