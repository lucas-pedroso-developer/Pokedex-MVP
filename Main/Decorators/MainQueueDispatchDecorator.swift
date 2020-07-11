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
    
extension MainQueueDispatchDecorator: GetPokemonDetail where T: GetPokemonDetail {
    
    public func get(url: URL, completion: @escaping (Result<PokemonDetail, DomainError>) -> ()) {
        instance.get(url: url, completion: { result in
                self.dispatch {
                    completion(result)
                }
            }
        )
    }
    public func getSpecie(url: URL, completion: @escaping (Result<SpecieDetail, DomainError>) -> ()) {
        instance.getSpecie(url: url, completion: { result in
                self.dispatch {
                    completion(result)
                }
            }
        )
    }
    
    public func getEvolution(url: URL, completion: @escaping (Result<EvolutionChainDetail, DomainError>) -> ()) {
        instance.getEvolution(url: url, completion: { result in
                self.dispatch {
                    completion(result)
                }
            }
        )
    }
}
