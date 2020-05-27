import SwiftUI

struct ComicDetailView: View {
    var comic: Comic
    
    var body: some View {
        ScrollView {
            VStack {
                image
                title
                description
                creators
                
            }.navigationBarTitle(Text(comic.title!))
                .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

extension ComicDetailView {
    private var image: some View {
        AsyncImage(
            loader: ImageLoader(thumbnail: comic.thumbnail, size: .large),
            placeholder: Spinner(isAnimating: true, style: .medium),
            configuration: { $0.resizable() }
        ).aspectRatio(contentMode: .fit)
        .eraseToAnyView()
    }
}

extension ComicDetailView {
    private var title: some View {
        Text(comic.title!)
            .padding()
            .foregroundColor(Color(UIColor.label))
            .font(.title)
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension ComicDetailView {
    private var description: some View {
        VStack {
            Text("Description")
                .padding()
                .foregroundColor(Color(UIColor.label))
                .font(.headline)
            
            
            Text(comic.description != nil ? comic.description! : "Missing")
                .padding()
                .foregroundColor(Color(UIColor.label))
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }.background(Color(UIColor.systemBackground))
    }
}

extension ComicDetailView {
    private var creators: some View {
        VStack {
            Text("Who created this piece?")
            .padding()
            .foregroundColor(Color(UIColor.label))
                .font(.headline)
            
            List {
                ForEach((comic.creators?.items)!, id: \.name) { creator in
                    Text(creator.name!)
                        .padding(4)
                        .foregroundColor(Color(UIColor.label))
                        .font(.body)
                }
            }
        }
    }
}
