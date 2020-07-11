import Foundation
import Domain

public struct SpecieDetailViewModel : Model {
    public let color : ColorViewModel?
    public let evolution_chain : Evolution_chainViewModel?
    public let varieties : [VarietiesViewModel]?
    public let base_happiness : Int?
    public let capture_rate : Int?
    public let flavor_text_entries : [Flavor_text_entriesViewModel]?
    
        
    public init(color : ColorViewModel?, evolution_chain : Evolution_chainViewModel?, varieties : [VarietiesViewModel]?, base_happiness : Int?, capture_rate : Int?, flavor_text_entries : [Flavor_text_entriesViewModel]?) {
        self.color = color
        self.evolution_chain = evolution_chain
        self.varieties = varieties
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.flavor_text_entries = flavor_text_entries
    }
}
