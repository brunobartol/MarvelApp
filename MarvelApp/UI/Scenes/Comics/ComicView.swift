import SwiftUI

struct ComicView: View {
    
    @ObservedObject private var viewModel: ComicViewModel
    @State private var showSearch: Bool = false
    
    init(viewModel: ComicViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        ZStack {
            VStack {
                searchField
                
                if self.showSearch {
                    SearchView<ComicViewModel>(viewModel: self.viewModel)
                } else {
                    ListView<ComicViewModel>(viewModel: self.viewModel)
                }
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

extension ComicView {
    private var searchField: some View {
        SearchBar(
            show: self.$showSearch,
            text: $viewModel.name
        ).padding(.bottom, 30)
    }
}

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView(viewModel: ComicViewModel(scheduler: DispatchQueue(label: "Test")))
    }
}
