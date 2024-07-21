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


    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    Spacer().frame(height: 10)
                    Text("News")
                        .font(.largeTitle).bold()
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .background(Color(.clear))
                }
               
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(filteredArticles) { article in
                            NavigationLink(destination: ArticleDetailsView(article: article)) {
                                ArticleRow(article: article)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .background(Color.white)
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
                    .shadow(radius: 1)
            } placeholder: {
                ProgressView().frame(width: 50, height: 50)
            }

            VStack(alignment: .leading) {
                Text(article.title)
                    .multilineTextAlignment(.leading)
                    .frame(width: 330, alignment: .leading)
                    .lineLimit(nil)
                    .font(.callout)
                    .foregroundColor(.black)

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
        searchBar.placeholder = "Search News Here"
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
