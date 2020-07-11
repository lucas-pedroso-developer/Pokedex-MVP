import Foundation
import Domain

public struct PokemonViewModel : Model {
    public let name : String?
    public let url : String?

    public init(name : String?, url : String?) {
        self.name = name
        self.url = url
    }

}
