import SwiftUI

struct ComicCell: View {
    var comic: Comic
    
    var body: some View {
        HStack {
            NavigationLink(destination: ComicDetailView(comic: comic)) {
                Spacer()
                
                VStack {
                    AsyncImage(
                        loader: ImageLoader(thumbnail: comic.thumbnail, size: .large),
                        placeholder: self.spinner,
                        configuration: { $0.resizable() }
                    ).frame(minWidth: 100, maxWidth: 250, minHeight: 150, maxHeight: 350, alignment: .center)
                        .scaledToFit()
                        .background(Color(UIColor.systemBackground))
                    
                    VStack(alignment: .leading) {
                        Text(comic.title!)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                        Text(comic.issn!)
                            .foregroundColor(Color(UIColor.label))
                            .padding()
                    }.padding()
                    
                }.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2.5, alignment: .center)
                
                Spacer()
            }
        }
    }
}

extension ComicCell {
    private var spinner: Spinner {
        Spinner(isAnimating: true, style: .medium)
    }
}
