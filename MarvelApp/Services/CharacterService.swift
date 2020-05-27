import Combine
import SwiftUI

protocol CharacterServiceType {
    func charactersByName(name: String) -> Future<[Character], ApiError>
}

final class CharacterService {
    public static let shared = CharacterService()
    private let decoder = JSONDecoder()
    
    private init() {}
}

extension CharacterService: CharacterServiceType {
    func charactersByName(name: String) -> Future<[Character], ApiError> {
        return Future<[Character], ApiError> { [unowned self] promise in
            do {
                try MarvelAPI
                    .charactersbyName(name: name)
                    .request()
                    .responseJSON { response in
                        guard let data = response.data else {
                            promise(.failure(.responseError(response.response!.statusCode)))
                            return
                        }
                        
                        do {
                            let characterResponse = try self.decoder.decode(CharacterDataWrapper.self, from: data)
                            guard let characters = characterResponse.data?.results else {
                                promise(.failure(.genericError))
                                return
                            }
                            promise(.success(characters))
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
