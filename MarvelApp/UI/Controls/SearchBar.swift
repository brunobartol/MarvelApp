import SwiftUI
import Combine

struct SearchBar: View {
    @Binding var text: String
    var image: Image
    var placeholder: String
    
    var body: some View {
        HStack {
            self.image.foregroundColor(Color(UIColor.secondaryLabel))
            TextField(placeholder, text: self.$text)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.secondaryLabel), lineWidth: 1))
            }.frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/10, alignment: .center)
        }
}
