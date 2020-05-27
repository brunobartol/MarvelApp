import Alamofire
import AlamofireImage

enum MarvelAPI {
    case charactersbyName(name: String)
    case comicsByName(name: String)
    case image(destination: String)
}

extension MarvelAPI: Router {
    
    private var session: Session { Session.default }
    
    var baseUrlString: String { "https://gateway.marvel.com" }
    
    private var privateKey: String { "4c605f168e60bde541e6a0f6b318873071f7f3c9" }
    private var apiKey: String { "f77e8f18458ca67aebd80b7bf22d93b2" }

    
    var path: String {
        switch self {
        case .charactersbyName: return "/v1/public/characters"
        case .comicsByName: return "/v1/public/comics"
        case .image: return ""
        }
    }
    
    var method: HTTPMethod { .get }
    
    var headers: HTTPHeaders? {
        [
            //"Content-Type": "application/json; charset=UTF8"
            "Accept": "*/*"
        ]
    }
}

extension MarvelAPI {
    func asURLRequest() throws -> URLRequest {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timeStamp)\(privateKey)\(apiKey)".md5
        
        let commonParams = [
            "ts": timeStamp,
            "apikey": apiKey,
            "hash": hash
        ]
        
        var parameters: [String: String] = [:]
        
        switch self {
        case .charactersbyName(let name):
            parameters = [ "nameStartsWith": name]
            commonParams.forEach { parameters.updateValue($0.value, forKey: $0.key) }
        case .comicsByName(let name):
            parameters = [ "titleStartsWith": name]
            commonParams.forEach { parameters.updateValue($0.value, forKey: $0.key) }
        default:
            parameters = commonParams
        }
        
        var url: URL
        
        switch self {
        case .image(let destination):
            url = try destination.asURL()
        default:
            url = try baseUrlString.asURL()
            url.appendPathComponent(path)
        }
        
        var request = URLRequest(url: url)
        request.method = method
        
        let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(arrayEncoding: .noBrackets), destination: .queryString)

        let encodedRequest = try encoder.encode(parameters, into: request)
        
        return encodedRequest
    }
}

extension MarvelAPI {
    func request() throws -> DataRequest {
        session.request(try asURLRequest())
    }
}

