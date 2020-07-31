import SwiftUI

struct SearchView<T: ViewModelProtocol>: View {
    @ObservedObject private var viewModel: T
    @State private var isPresented: Bool = false
    @State private var selectedItem: T.T?
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.name.isEmpty {
                title
            }
            list
        }
    }
}

extension SearchView {
    private var title: some View {
        HStack {
            Text("Recently searched")
                .font(.title)
                .fontWeight(.bold)
                .background(Color(UIColor.systemBackground))
            
            Spacer()
        }.padding(.horizontal)
        .background(Color(UIColor.systemBackground))
    }
}

extension SearchView {
    private var list: some View {
        List {
            ForEach(viewModel.name.isEmpty ? viewModel.recentlySearched : viewModel.dataSource, id: \.id) { item in
                ListCell<T.T>(listItem: item)
                    .onTapGesture {
                        self.isPresented.toggle()
                        self.selectedItem = item
                        self.viewModel.updateRecentlySearched(element: item)
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            DetailView<T.T>(item: self.$selectedItem)
        }
    }
}
