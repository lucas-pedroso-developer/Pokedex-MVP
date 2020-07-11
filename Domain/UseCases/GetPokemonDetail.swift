import Foundation

public protocol GetPokemonDetail {
    func get(url: URL, completion: @escaping (Result<PokemonDetail, DomainError>) -> ())
    func getSpecie(url: URL, completion: @escaping (Result<SpecieDetail, DomainError>) -> ())
    func getEvolution(url: URL, completion: @escaping (Result<EvolutionChainDetail, DomainError>) -> ())
}
