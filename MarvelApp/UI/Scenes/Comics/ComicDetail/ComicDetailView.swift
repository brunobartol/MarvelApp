import SwiftUI

struct ComicDetailView: View {
    @Binding var comic: Comic?
    
    var body: some View {
        VStack {
            Section {
                description
            }.padding()
            
            Section {
                characterList
            }.padding(.horizontal, 5)
                .padding(.vertical)
        }.padding(.horizontal, 5)
            .padding(.vertical)
    }
}

extension ComicDetailView {
    private var description: some View {
        guard let description = self.comic?.description else { return Text("Missing description").eraseToAnyView() }
        
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

extension ComicDetailView {
    private var characterList: some View {
        guard let characters = self.comic?.characters else { return EmptyView().eraseToAnyView() }
        guard let items = characters.items else { return EmptyView().eraseToAnyView() }
        
        return VStack {
            Text(items.count == 1 ? "Main character" : "Characters" )
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor.label))
            
            Divider()
            
            ForEach(items, id: \.id) { character in
                HStack {
                    Text(character.name!)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Spacer()
                }
            }
        }.padding()
            .eraseToAnyView()
    }
}
