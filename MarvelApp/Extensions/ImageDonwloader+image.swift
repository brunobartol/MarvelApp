import Combine
import AlamofireImage

let imageDownloader = ImageDownloader(
    configuration: .default,
    downloadPrioritization: .fifo,
    maximumActiveDownloads: 4,
    imageCache: AutoPurgingImageCache()
)

extension ImageDownloader {
    func image(thumbnail: ApiImage?, size: ImageSize) -> Future<UIImage?, Never> {
        return Future<UIImage?, Never> { promise in
            guard let thumbnail = thumbnail else { return }
            
            let urlString = thumbnail.path! + size.rawValue + thumbnail.ext!
            
            do {
                let urlRequest = try MarvelAPI.image(destination: urlString).asURLRequest()
                                                
                imageDownloader.download(urlRequest) { response in
                    if case .success(let image) = response.result {
                        promise(.success(image))
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
