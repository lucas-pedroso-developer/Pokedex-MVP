import Foundation

public struct Types : Model {
    let slot : Int?
    let type : Type?

    public init(slot : Int?, type : Type?) {
        self.slot = slot
        self.type = type
    }

}
