import SwiftUI

struct ComicView: View {
    
    @ObservedObject private var viewModel: ComicViewModel
    @State private var isPresented: Bool = false
    @State var selectedComic: Comic?
    
    init(viewModel: ComicViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                searchBar
                comicList
            }.navigationBarTitle("Comics", displayMode: .inline)
            
        }.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

extension ComicView {
    private var comicList: some View {
        List {
            ForEach(viewModel.dataSource, id: \.id) { comic in
                ComicCell(comic: comic).eraseToAnyView()
            }
        }
    }
}

extension ComicView {
    private var searchBar: some View {
        SearchBar(
            text: $viewModel.comicName,
            image: Image(systemName: "book"),
            placeholder: "Search comics"
        )
    }
}

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView(viewModel: ComicViewModel(scheduler: DispatchQueue(label: "Test")))
    }
}
