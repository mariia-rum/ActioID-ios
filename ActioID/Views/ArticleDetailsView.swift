import SwiftUI

struct ArticleDetailsView: View {
    let article: NewsArticle

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(article.title)
                .font(.largeTitle)
                .bold()

            Text(article.pubDate)
                .font(.body)

            Text(article.description)
                .font(.body)

            Link("Read Full Article", destination: URL(string: article.link)!)
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.top, 20)

            Spacer()
        }
        .padding()
        .navigationTitle("Article Details")
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(article: NewsArticle(id: UUID().uuidString, title: "Sample Article", link: "https://example.com", pubDate: "2024-06-22", description: "This is a sample description of the article."))
    }
}
