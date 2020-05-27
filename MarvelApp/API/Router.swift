import Alamofire

protocol Router: URLRequestConvertible {
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: String] { get }
    
    func body() throws -> Data?
    func asURLRequest() throws -> URLRequest
    func request() throws -> DataRequest
}

extension Router {
    var parameters: [String: String] { [:] }
    func body() throws -> Data? { nil }
}
