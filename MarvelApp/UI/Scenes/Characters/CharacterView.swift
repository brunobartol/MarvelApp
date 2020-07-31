import Foundation
import SwiftUI

struct CharacterView: View {
    @ObservedObject private var viewModel: CharacterViewModel
    @State private var showSearch: Bool = false
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        ZStack {
            VStack {
                searchField
                
                if self.showSearch {
                    SearchView<CharacterViewModel>(viewModel: self.viewModel)
                } else {
                    ListView<CharacterViewModel>(viewModel: self.viewModel)
                }
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }.background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

extension CharacterView {
    private var searchField: some View {
        SearchBar(
            show: self.$showSearch,
            text: $viewModel.name
        ).padding(.bottom, 30)
    }
}
