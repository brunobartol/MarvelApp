import Foundation

struct Comic: Identifiable {
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: JSONAny?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [Url]?
    let series: SeriesSummary?
    let variants: [ComicSummary]?
    let collections: [JSONAny]?
    let collectedIssues: [JSONAny]?
    let dates: [ComicDate]?
    let prices: [ComicPrice]?
    let thumbnail: ApiImage?
    let images: [ApiImage]?
    let creators: CreatorList?
    let characters: CharacterList?
    let stories: StoryList?
    let events: EventList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case digitalId
        case title
        case issueNumber
        case variantDescription
        case description
        case modified
        case isbn
        case upc
        case diamondCode
        case ean
        case issn
        case format
        case pageCount
        case textObjects
        case resourceURI
        case urls
        case series
        case variants
        case collections
        case collectedIssues
        case dates
        case prices
        case thumbnail
        case images
        case creators
        case characters
        case stories
        case events
    }
}

extension Comic: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.digitalId = try container.decodeIfPresent(Int.self, forKey: .digitalId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.issueNumber = try container.decodeIfPresent(JSONAny.self, forKey: .issueNumber)
        self.variantDescription = try container.decodeIfPresent(String.self, forKey: .variantDescription)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.modified = try container.decodeIfPresent(String.self, forKey: .modified)
        self.isbn = try container.decodeIfPresent(String.self, forKey: .isbn)
        self.upc = try container.decodeIfPresent(String.self, forKey: .upc)
        self.diamondCode = try container.decodeIfPresent(String.self, forKey: .diamondCode)
        self.ean = try container.decodeIfPresent(String.self, forKey: .ean)
        self.issn = try container.decodeIfPresent(String.self, forKey: .issn)
        self.format = try container.decodeIfPresent(String.self, forKey: .format)
        self.pageCount = try container.decodeIfPresent(Int.self, forKey: .pageCount)
        self.textObjects = try container.decodeIfPresent([TextObject].self, forKey: .textObjects)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.urls = try container.decodeIfPresent([Url].self, forKey: .urls)
        self.series = try container.decodeIfPresent(SeriesSummary.self, forKey: .series)
        self.variants = try container.decodeIfPresent([ComicSummary].self, forKey: .variants)
        self.collections = try container.decodeIfPresent([JSONAny].self, forKey: .collections)
        self.collectedIssues = try container.decodeIfPresent([JSONAny].self, forKey: .collectedIssues)
        self.dates = try container.decodeIfPresent([ComicDate].self, forKey: .dates)
        self.prices = try container.decodeIfPresent([ComicPrice].self, forKey: .prices)
        self.thumbnail = try container.decodeIfPresent(ApiImage.self, forKey: .thumbnail)
        self.images = try container.decodeIfPresent([ApiImage].self, forKey: .images)
        self.creators = try container.decodeIfPresent(CreatorList.self, forKey: .creators)
        self.characters = try container.decodeIfPresent(CharacterList.self, forKey: .characters)
        self.stories = try container.decodeIfPresent(StoryList.self, forKey: .stories)
        self.events = try container.decodeIfPresent(EventList.self, forKey: .events)
    }
}

extension Comic: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(digitalId, forKey: .digitalId)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(issueNumber, forKey: .issueNumber)
        try container.encodeIfPresent(variantDescription, forKey: .variantDescription)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(modified, forKey: .modified)
        try container.encodeIfPresent(isbn, forKey: .isbn)
        try container.encodeIfPresent(upc, forKey: .upc)
        try container.encodeIfPresent(diamondCode, forKey: .diamondCode)
        try container.encodeIfPresent(ean, forKey: .ean)
        try container.encodeIfPresent(issn, forKey: .issn)
        try container.encodeIfPresent(format, forKey: .format)
        try container.encodeIfPresent(pageCount, forKey: .pageCount)
        try container.encodeIfPresent(textObjects, forKey: .textObjects)
        try container.encodeIfPresent(resourceURI, forKey: .resourceURI)
        try container.encodeIfPresent(urls, forKey: .urls)
        try container.encodeIfPresent(series, forKey: .series)
        try container.encodeIfPresent(variants, forKey: .variants)
        try container.encodeIfPresent(collections, forKey: .collections)
        try container.encodeIfPresent(collectedIssues, forKey: .collectedIssues)
        try container.encodeIfPresent(dates, forKey: .dates)
        try container.encodeIfPresent(prices, forKey: .prices)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(creators, forKey: .creators)
        try container.encodeIfPresent(characters, forKey: .characters)
        try container.encodeIfPresent(stories, forKey: .stories)
        try container.encodeIfPresent(events, forKey: .events)
    }
}

