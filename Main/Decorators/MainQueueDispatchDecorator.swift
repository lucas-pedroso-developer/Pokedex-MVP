import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
        
}

extension MainQueueDispatchDecorator: GetPokemons where T: GetPokemons {
    public func get(url: URL, completion: @escaping (Result<Pokemons, DomainError>) -> Void) {
        instance.get(url: url, completion: { result in
            self.dispatch {
                completion(result)
            }
        }
    )}
}
    