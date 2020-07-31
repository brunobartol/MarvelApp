import SwiftUI

struct ListCell<T: ListItemProtocol>: View {
    let listItem: T
    
    var body: some View {
    
    ZStack(alignment: .leading) {
        
            //background color
        Color(UIColor.systemBackground)
            
            HStack {
                ZStack {
                    //character thumbnail
                    AsyncImage(
                        loader: ImageLoader(thumbnail: listItem.thumbnail, size: .small),
                        placeholder: self.spinner,
                        configuration: { $0.resizable() }
                    ).aspectRatio(contentMode: .fill)
  
                }.frame(width: 150, height: 200, alignment: .center)
                
                VStack(alignment: .leading) {
                    
                    Text(listItem.name!)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 5)
                        .padding(.top, 20)
                    
                    HStack {
                        Text(listItem.description!)
                            .font(.caption)
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 10)
                            .padding(.trailing, 30)
                        
                        Spacer()
                        
                    }.padding(.horizontal, 5)
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Text("More info")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(10)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .fixedSize()
                            .padding()
                    }
                    
                }.padding(.horizontal, 10)
                
                Spacer()
            }
        }
        .frame(width: 400, height: 200, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .background(
            Ellipse()
            .fill(Color(UIColor.systemBackground))
            .padding(.horizontal)
            .shadow(color: Color(UIColor.lightGray).opacity(0.5), radius: 20, x: 10, y: 20)
        )
        .padding(.bottom, 20)
    }
}

extension ListCell {
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
