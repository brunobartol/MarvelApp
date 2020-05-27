import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State var isDark: Bool
    
    var body: some View {
        Form {
            Section(
                header: Text("Welcome to your app's settings").font(.headline).foregroundColor(Color(UIColor.label))
            ) {
                HStack {
                    Toggle(isOn: $isDark) {
                        Text("Change to dark mode")
                            .padding()
                            .font(.body)
                            .foregroundColor(Color(UIColor.secondaryLabel))
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
            }
        }.background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

