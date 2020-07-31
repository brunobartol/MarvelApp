import SwiftUI

protocol ViewModelProtocol: ObservableObject {
    associatedtype T: ListItemProtocol
    
    var name: String { get set }
    var dataSource: [T] { get set }
    var recentlySearched: [T] { get set }
    var popular: [T] { get set }
    
    func updateRecentlySearched(element: T)
}
