import SwiftUI

struct LaunchMainView: View {
    @State private var selectedTab: Tab = .characters
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CharacterView(viewModel: CharacterViewModel())
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Heroes")
            }.tag(Tab.characters)
            
            NavigationView {
                ComicView(viewModel: ComicViewModel())
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Comics")
            }.tag(Tab.comics)
            
            NavigationView {
                SettingsView(isDark: true)
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }.tag(Tab.settings)
        }
    }
}

private extension LaunchMainView {
    enum Tab: Int {
        case characters
        case comics
        case settings
    }
}

