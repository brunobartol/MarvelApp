import SwiftUI
import BottomBar_SwiftUI

struct LaunchMainView: View {
    
    @State var selectedIndex: Int = 0
    
    let items: [BottomBarItem] = [
        BottomBarItem(icon: Image(systemName: "person.fill"), title: "Heroes", color: Color(UIColor.label)),
        BottomBarItem(icon: Image(systemName: "book.fill"), title: "Comics", color: Color(UIColor.label)),
        BottomBarItem(icon: Image(systemName: "gear"), title: "Settings", color: Color(UIColor.label))
    ]
    
    private func showContent(for tab: Int) -> some View {
        switch tab {
        case 1:
            return ComicView(viewModel: ComicViewModel(scheduler: .init(label: "Comics-Thread"))).eraseToAnyView()
        case 2:
            return SettingsView(isDark: true).eraseToAnyView()
        default:
            return CharacterView(viewModel: CharacterViewModel(scheduler: .init(label: "Characters-Thread"))).eraseToAnyView()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                showContent(for: self.selectedIndex)
                
                BottomBar(selectedIndex: self.$selectedIndex, items: self.items)
                .background(Color(UIColor.systemBackground))
            }
        }
    }
}

