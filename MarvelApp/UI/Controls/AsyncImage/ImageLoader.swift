import Combine
import SwiftUI

final class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private let thumbnail: ApiImage?
    private let size: ImageSize
    private(set) var cancellables = Set<AnyCancellable>()
    
    init(thumbnail: ApiImage?, size: ImageSize) {
        self.thumbnail = thumbnail
        self.size = size
        
        fetchImage()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func fetchImage() {
        imageDownloader
            .image(thumbnail: thumbnail, size: size)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                
                switch value {
                case .finished:
                    self?.cancellables.removeAll()
                    break
                case .failure(_):
                    self?.image = nil
                }
            }) { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
