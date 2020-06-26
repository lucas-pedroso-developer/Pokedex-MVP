import Foundation
import Domain

public struct MainViewModel: Model {
    var count : Int?
    var next : String?
    var previous : String?
    var results : [ResultsViewModel]?

    public init(count: Int?, next: String, previous: String, results: [ResultsViewModel]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

public struct ResultsViewModel : Model {
    let name : String?
    let url : String?
       
    public init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
}
