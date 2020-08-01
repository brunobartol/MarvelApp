import SwiftUI

struct Theme {
    static func toggleTheme(isDark: Binding<Bool>) {
        if isDark.wrappedValue == true {
            SceneDelegate.shared?.window?.overrideUserInterfaceStyle = .light
        } else {
            SceneDelegate.shared?.window?.overrideUserInterfaceStyle = .dark
        }
    }
}
