import Foundation

struct CharacterSummary {
    let resourceURI: String?
    let name: String?
    let role: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case role
    }
}

extension CharacterSummary: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
    }
}

extension CharacterSummary: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(resourceURI, forKey: .resourceURI)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(role, forKey: .role)
    }
}

