import Foundation
import SwiftUI

struct CharacterView: View {
    @ObservedObject private var viewModel: CharacterViewModel
    @State private var isPresented: Bool = false
    @State var selectedCharacter: Character?
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        ZStack {
            VStack {
                searchField
                characterList
                    .padding()
            }.navigationBarTitle("Marvel Heroes", displayMode: .inline)
        }.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

extension CharacterView {
    private var searchField: some View {
        SearchBar(
            text: $viewModel.characterName,
            image: Image(systemName: "person"),
            placeholder: "Search heroes"
        )
    }
}

extension CharacterView {
    private var characterList: some View {
        List {
            ForEach(viewModel.dataSource, id: \.id) { character in
                HStack {
                    //character thumbnail
                    AsyncImage(
                        loader: ImageLoader(thumbnail: character.thumbnail, size: .small),
                        placeholder: self.spinner,
                        configuration: { $0.resizable() }
                    ).fixedSize()
                    
                    //character name
                    Text(character.name!).foregroundColor(Color(UIColor.label))
                    
                }.listRowBackground(Color(UIColor.systemBackground))
                .onTapGesture {
                    self.isPresented.toggle()
                    self.selectedCharacter = character
                }
            }
        }.sheet(isPresented: $isPresented) {
            CharacterDetailView(character: self.$selectedCharacter)
        }
    }
}

extension CharacterView {
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
