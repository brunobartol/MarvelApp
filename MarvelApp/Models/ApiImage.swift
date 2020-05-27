import Foundation

struct ApiImage: Equatable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension ApiImage: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.ext = try container.decodeIfPresent(String.self, forKey: .ext)
    }
}

extension ApiImage: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(ext, forKey: .ext)
    }
}
