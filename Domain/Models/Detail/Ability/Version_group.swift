import Foundation

public struct Version_group : Model {
    let name : String?
    let url : String?

    public init(name : String?, url : String?) throws {
        self.name = name
        self.url = url
    }

}
