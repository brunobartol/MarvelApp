import SwiftUI

struct CharacterDetailView: View {
    
    @Binding var character: Character?
    
    var body: some View {
        VStack {
            Section {
                description
            }.padding()
            
            Section {
                comicList
            }.padding(.horizontal, 5)
                .padding(.vertical)
            
            Section {
                seriesList
            }.padding(.horizontal, 5)
                .padding(.vertical)
        }.padding(.horizontal, 5)
            .padding(.vertical)
    }
}


extension CharacterDetailView {
    private var description: some View {
        guard let description = self.character?.description else { return Text("Missing description").eraseToAnyView() }
        
        return VStack(alignment: .leading, spacing: 5) {
            Text("Description")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
            
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
                .font(.body)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }.eraseToAnyView()
    }
}

extension CharacterDetailView {
    private var comicList: some View {
        guard let comics = self.character?.comics else { return EmptyView().eraseToAnyView() }
        guard let items = comics.items else { return EmptyView().eraseToAnyView() }
        
        return VStack {
            Text("Comics where you can find this character")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
            
            Divider()
            
            ForEach(items, id: \.id) { comic in
                HStack {
                    Text(comic.name!)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Spacer()
                }
            }
        }.padding()
            .eraseToAnyView()
    }
}

extension CharacterDetailView {
    private var seriesList: some View {
        guard let series = self.character?.series else { return EmptyView().eraseToAnyView() }
        guard let items = series.items else { return EmptyView().eraseToAnyView() }
        
        return VStack {
            Text("Series where you can find this character")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
            
            Divider()
            
            ForEach(items, id: \.self) { item in
                HStack {
                    Text(item.name!)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Spacer()
                }
            }
        }.padding()
            .eraseToAnyView()
    }
}
