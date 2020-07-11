import Foundation

public struct Stats : Model {
    let base_stat : Int?
    let effort : Int?
    let stat : Stat?

    public init(base_stat : Int?, effort : Int?, stat : Stat?) {
        self.base_stat = base_stat
        self.effort = effort
        self.stat = stat
    }
}
