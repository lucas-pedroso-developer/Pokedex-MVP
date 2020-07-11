import Foundation
import Domain

public struct TypesViewModel : Model {
    public let slot : Int?
    public let type : TypeViewModel?

    public init(slot : Int?, type : TypeViewModel?) {
        self.slot = slot
        self.type = type
    }

}
