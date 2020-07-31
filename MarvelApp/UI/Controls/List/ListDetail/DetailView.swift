import SwiftUI

struct DetailView<T: ListItemProtocol>: View {
    @Binding var item: T?
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    //character thumbnail
                    AsyncImage(
                        loader: ImageLoader(thumbnail: item?.thumbnail, size: .small),
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
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.black))
                    
                    Text(item!.description != nil ? item!.description! : "Missing")
                        .lineLimit(nil)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }.padding()
                
                VStack {
                    Text("List of stories where you can find this hero")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(UIColor.label))
                }
            }
        }
    }
}
