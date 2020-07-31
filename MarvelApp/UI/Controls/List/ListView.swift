import SwiftUI

struct ListView<T: ViewModelProtocol>: View {
    @ObservedObject private var viewModel: T
    @State private var modalPresented: Bool = false
    @State private var selectedElement: T.T?
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            FilterBar(viewModel: self.viewModel)
            
            List {
                ForEach(viewModel.dataSource, id: \.id) { element in
                    ListCell<T.T>(listItem: element)
                        .onTapGesture {
                            self.modalPresented.toggle()
                            self.selectedElement = element
                            self.viewModel.updateRecentlySearched(element: element)
                            
                            print("tap")
                    }
                }
            }.sheet(isPresented: $modalPresented) {
                VStack {
                    DetailView<T.T>(item: self.$selectedElement)
                    Text("Test")
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView<CharacterViewModel>(viewModel: CharacterViewModel()).environment(\.colorScheme, .light)
    }
}
