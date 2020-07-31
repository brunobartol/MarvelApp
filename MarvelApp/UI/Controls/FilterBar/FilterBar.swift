import SwiftUI
import BottomBar_SwiftUI

struct FilterBar<T: ViewModelProtocol>: View {
    @ObservedObject private var viewModel: T
    @State private var selectedIndex: Int = 0
    
    init(viewModel: T) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            withAnimation {
                HStack {
                    FilterBarItem(isSelected: self.selectedIndex == 0 ? true : false, title: "Popular")
                        .animation(.spring())
                        .onTapGesture {
                            withAnimation {
                                self.selectedIndex = 0
                                self.viewModel
                            }
                    }
                    Spacer()
                    FilterBarItem(isSelected: self.selectedIndex == 1 ? true : false, title: "A-Z")
                        .animation(.spring())
                        .onTapGesture {
                            withAnimation {
                                self.selectedIndex = 1
                            }
                    }
                    Spacer()
                    FilterBarItem(isSelected: self.selectedIndex == 2 ? true : false, title: "Last viewed")
                        .animation(.spring())
                        .onTapGesture {
                            withAnimation {
                                self.selectedIndex = 2
                            }
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct FilterBar_Previews: PreviewProvider {
    static var previews: some View {
        FilterBar(viewModel: CharacterViewModel()).environment(\.colorScheme, .light)
    }
}
