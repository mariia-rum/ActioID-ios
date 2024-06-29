import SwiftUI

struct ArticleDetailsView: View {
    let article: NewsArticles

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
               
                AsyncImage(url: URL(string: "https://www.bmj.de/SiteGlobals/Frontend/Images/logo-newsletter.jpg?__blob=normal")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
                
                // Title
                Text(article.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)

                // Publication Date
                Text(article.pubDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)

                // Description
                Text(article.description)
                    .font(.body)
                    .padding(.bottom, 16)

                // Link to Full Article
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
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(article: NewsArticles(id: UUID().uuidString, title: "Sample Article", link: "https://example.com", pubDate: "2024-06-22", description: "This is a sample description of the article."))
    }
}
