import Foundation

public protocol DetailView {
    func presentList(viewModel: DetailViewModel?)
    func presentSpecie(viewModel: SpecieDetailViewModel?)
    func presentEvolution(viewModel: EvolutionChainDetailViewModel?)
}
