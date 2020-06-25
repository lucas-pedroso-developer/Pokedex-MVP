import Foundation

public protocol GetPokemons {
    func get(url: URL, completion: @escaping (Result<Pokemons, DomainError>) -> ())
}
