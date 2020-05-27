import Foundation

struct CreatorList {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [CreatorSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

extension CreatorList: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decodeIfPresent(Int.self, forKey: .available)
        self.returned = try container.decodeIfPresent(Int.self, forKey: .returned)
        self.collectionURI = try container.decodeIfPresent(String.self, forKey: .collectionURI)
        self.items = try container.decodeIfPresent([CreatorSummary].self, forKey: .items)
    }
}

extension CreatorList: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(returned, forKey: .returned)
        try container.encodeIfPresent(collectionURI, forKey: .collectionURI)
        try container.encodeIfPresent(items, forKey: .items)
    }
}
