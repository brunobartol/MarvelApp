protocol ListItemProtocol: Decodable, Identifiable {
    var name: String? { get }
    var thumbnail: ApiImage? { get }
    var description: String? { get }
}
