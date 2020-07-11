import Foundation
import Domain

public struct StatsViewModel : Model {
    public let base_stat : Int?
    public let effort : Int?
    public let stat : StatViewModel?

    public init(base_stat : Int?, effort : Int?, stat : StatViewModel?) {
        self.base_stat = base_stat
        self.effort = effort
        self.stat = stat
    }
}
