import Foundation

struct TextObject {
    let type: String?
    let language: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case language
        case text
    }
}

extension TextObject: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
    }
}

extension TextObject: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(text, forKey: .text)
    }
}
