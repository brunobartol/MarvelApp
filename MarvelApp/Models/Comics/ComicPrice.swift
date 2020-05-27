import Foundation

struct ComicPrice {
    let type: String?
    let price: Float?
    
    enum CodingKeys: String, CodingKey {
        case type
        case price
    }
}

extension ComicPrice: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.price = try container.decodeIfPresent(Float.self, forKey: .price)
    }
}

extension ComicPrice: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(price, forKey: .price)
    }
}
