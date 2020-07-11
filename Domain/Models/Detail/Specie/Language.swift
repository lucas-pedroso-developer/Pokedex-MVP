import Foundation

public struct Language : Model {
    let name : String?
    let url : String?

    public init(name: String, url: String) throws {
        self.name = name
        self.url = url
    }

}
