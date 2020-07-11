import Foundation

public struct EvolutionChainDetail : Model {
    let baby_trigger_item : String?
    let chain : Chain?
    let id : Int?

    public init(baby_trigger_item : String?, chain : Chain?, id : Int?) {
        self.baby_trigger_item = baby_trigger_item
        self.chain = chain
        self.id = id
    }

}
