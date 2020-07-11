import Foundation
import Domain

public struct VarietiesViewModel: Model {
    public let is_default : Bool?
    public let pokemon : Pokemon?

    public init(is_default : Bool?, pokemon : Pokemon?) {
        self.is_default = is_default
        self.pokemon = pokemon
    }

}
