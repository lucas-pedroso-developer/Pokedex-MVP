import Foundation
import Domain

public final class RemoteGetPokemonDetail: GetPokemonDetail {
    
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func get(url: URL, completion: @escaping (Result<PokemonDetail, DomainError>) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: PokemonDetail = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
    
    public func getSpecie(url: URL, completion: @escaping (Result<SpecieDetail, DomainError>) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: SpecieDetail = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
    
    public func getEvolution(url: URL, completion: @escaping (Result<EvolutionChainDetail, DomainError>) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: EvolutionChainDetail = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
