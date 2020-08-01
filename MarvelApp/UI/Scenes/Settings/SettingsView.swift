import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State var isDark: Bool
    
    var body: some View {
        List {
            Section(header: Text("Appearance".uppercased())) {
                Toggle(isOn: $isDark) {
                    Text("Enable dark theme")
                        .padding(2)
                        .font(.body)
                        .foregroundColor(Color(UIColor.label))
                }.onTapGesture {
                    Theme.toggleTheme(isDark: self.$isDark)
                }
            }.onAppear {
                switch self.colorScheme {
                case .light:
                    self.isDark = false
                case .dark:
                    self.isDark = true
                }
            }
            
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .compact)
            .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isDark: true).environment(\.colorScheme, .dark)
    }
}
