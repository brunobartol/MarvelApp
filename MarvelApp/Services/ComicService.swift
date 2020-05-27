import Combine
import SwiftUI

protocol ComicServiceType {
    func fetchComics(name: String) -> Future<[Comic], ApiError>
}

final class ComicService {
    public static let shared = ComicService()
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
}

extension ComicService: ComicServiceType {
    func fetchComics(name: String) -> Future<[Comic], ApiError> {
        return Future<[Comic], ApiError> { [unowned self] promise in
            do {
                try MarvelAPI
                    .comicsByName(name: name)
                    .request()
                    .responseJSON { response in
                        guard let data = response.data else {
                            promise(.failure(.genericError))
                            print(response)
                            return
                        }
                        
                        do {
                            let comicResponse = try self.decoder.decode(ComicDataWrapper.self, from: data)
                            guard let comics = comicResponse.data?.results else {
                                promise(.failure(.genericError))
                                return
                            }
                            promise(.success(comics))
                        } catch {
                            print(error)
                        }
                }
            } catch {
                print(error)
            }
        }
    }
    
}

