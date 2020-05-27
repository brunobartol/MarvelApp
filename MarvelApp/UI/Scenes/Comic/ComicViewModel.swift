import Combine
import SwiftUI

class ComicViewModel: ObservableObject {
    @Published var comicName: String = ""
    @Published var dataSource: [Comic] = []
    
    static var safeAreaInsetBottom: CGFloat {
        UIApplication.shared.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.bottom ?? 0
    }
    
    @Published private(set) var keyboardOffset: CGFloat = 0
    @Published private(set) var keyboardAnimationDuration: Double = 0
    private lazy var service = ComicService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(
        scheduler: DispatchQueue = DispatchQueue(label: "ComicViewModel")
    ) {
        
        $comicName
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
        service.fetchComics(name: name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                
                switch value {
                case .finished:
                    break
                case .failure(_):
                    self.dataSource = []
                }
            }) { [weak self] comics in
                guard let self = self else { return }
                self.dataSource = comics
            }
            .store(in: &cancellables)
    }
}

