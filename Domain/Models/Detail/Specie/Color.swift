import Foundation

public struct Color : Model {
    let name : String?
    let url : String?
    
    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }

}
