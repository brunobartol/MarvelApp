import SwiftUI
import Combine

enum ImageSize: String {
    case small = "/portrait_uncanny."
    case large = "/detail."
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    
    init(loader: ImageLoader, placeholder: Placeholder? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        
        self.loader = loader
        self.placeholder = placeholder
        self.configuration = configuration
        
        loader.fetchImage()
    }
    
    var body: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
}
