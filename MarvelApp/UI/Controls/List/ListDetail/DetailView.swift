import SwiftUI

struct DetailView<T: ListItemProtocol, Content: View>: View {
    @Binding var item: T?
    let content: Content
    
    init(item: Binding<T?>, @ViewBuilder content: () -> Content) {
        self._item = item
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    //character or comic thumbnail
                    AsyncImage(
                        loader: ImageLoader(thumbnail: item?.thumbnail, size: .large),
                        placeholder: Spinner(isAnimating: true, style: .medium),
                        configuration: { $0.resizable() }
                    ).aspectRatio(contentMode: .fill)
                    
                }.frame(maxWidth: .infinity, maxHeight: 450)
                .edgesIgnoringSafeArea(.top)
                
                Spacer().frame(height: 100)
                
                HStack {
                    Text(item!.name!)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.label))

                    Spacer()
                }.padding()
            
                content
                
            }.background(Color(UIColor.systemBackground))
        }
    }
}
