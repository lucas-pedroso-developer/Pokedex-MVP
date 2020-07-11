import Foundation
import Domain

public struct EvolutionChainDetailViewModel : Model {
    public let baby_trigger_item : String?
    public let chain : ChainViewModel?
    public let id : Int?

    public init(baby_trigger_item : String?, chain : ChainViewModel?, id : Int?) {
        self.baby_trigger_item = baby_trigger_item
        self.chain = chain
        self.id = id
    }

}
