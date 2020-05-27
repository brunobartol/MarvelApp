import Combine
import SwiftUI

final class CharacterViewModel: ObservableObject {
    @Published var characterName: String = ""
    @Published var dataSource: [Character] = []
    
    static var safeAreaInsetBottom: CGFloat {
        UIApplication.shared.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.bottom ?? 0
    }
    
    @Published private(set) var keyboardOffset: CGFloat = 0
    @Published private(set) var keyboardAnimationDuration: Double = 0
    private lazy var service = CharacterService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(
        scheduler: DispatchQueue = DispatchQueue(label: "CharacterViewModel")
    ) {
        $characterName
            .dropFirst(1)
            .debounce(for: .seconds(0.3), scheduler: scheduler)
            .sink(receiveValue: fetchByName)
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .handleEvents(receiveOutput: { [weak self] _ in self?.keyboardOffset = 0 })
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification))
            .map(\.userInfo)
            .compactMap { ($0?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue }
            .assign(to: \.keyboardAnimationDuration, on: self)
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map(\.userInfo)
            .compactMap { ($0?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height }
            .map { $0 * -1 + Self.safeAreaInsetBottom }
            .assign(to: \.keyboardOffset, on: self)
            .store(in: &cancellables)
    }
    
    func fetchByName(name: String) {
        service.charactersByName(name: name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                switch value {
                case .finished:
                    break
                case .failure(_):
                    self?.dataSource = []
                }
            }) { [weak self] characters in
                self?.dataSource = characters
            }
            .store(in: &cancellables)
    }
}
