import Foundation
import Domain

public final class RemoteGetPokemons: GetPokemons {
    
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
    //public init(httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func get(url: URL, completion: @escaping (Result<Pokemons, DomainError>) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: Pokemons = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
