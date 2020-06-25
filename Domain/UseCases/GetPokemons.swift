import Foundation

public protocol HttpGet {
    func get(url: String, completion: @escaping (Result<Data?, DomainError>) -> ())
}
