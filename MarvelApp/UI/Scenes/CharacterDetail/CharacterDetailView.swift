import SwiftUI

struct CharacterDetailView: View {
    @Binding var character: Character?
    
    var body: some View {
        ScrollView {
            VStack {
                image
                title
                
                VStack {
                    Text("Description")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                    
                    description
                }
                
                VStack {
                    Text("List of comics where you can find this hero")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                    
                    comicList
                        .font(.body)
                        .foregroundColor(Color(UIColor.label))
                }
            }
        }
    }
}


//MARK: - Character name
extension CharacterDetailView {
    private var title: some View {
        Text(character!.name!)
            .padding()
            .font(.largeTitle)
            .foregroundColor(Color(UIColor.label))
            .fixedSize(horizontal: false, vertical: true)
    }
}

//MARK: - Description
extension CharacterDetailView {
    private var description: some View {
        Text(character!.description != nil ? character!.description! : "Missing")
            .lineLimit(nil)
            .font(.body)
            .foregroundColor(Color(UIColor.secondaryLabel))
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
}

//MARK: - Image
extension CharacterDetailView {
    private var image: some View {
        AsyncImage(
            loader: ImageLoader(thumbnail: character?.thumbnail, size: .large),
            placeholder: Spinner(isAnimating: true, style: .medium),
            configuration: { $0.resizable() }
        ).scaledToFit()
            .background(Color(UIColor.systemBackground))
    }
}

//MARK: - Comics
extension CharacterDetailView {
    private var comicList: some View {
        List {
            ForEach((character?.comics?.items)!, id: \.id) { comic in
                Text(comic.name!)
            }
        }
    }
}
