import Foundation
import Domain

public struct MainViewModel: Model {
    public var count : Int?
    public var next : String?
    public var previous : String?
    public var results : [ResultsViewModel]?

    public init(count: Int?, next: String, previous: String, results: [ResultsViewModel]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

public struct ResultsViewModel : Model {
    public let name : String?
    public let url : String?
       
    public init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
}
