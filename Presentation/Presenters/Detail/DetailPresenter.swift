import Foundation
import Domain
import UIKit

public final class DetailPresenter {
    private let alertView: AlertView
    private let getPokemonDetail: GetPokemonDetail
    private let loadingView: LoadingView
    private var detailView: DetailView
    private var detailViewModel: DetailViewModel?
    private var specieDetailViewModel: SpecieDetailViewModel?
    private var evolutionChainViewModel: EvolutionChainDetailViewModel?
    
    public init(alertView: AlertView, getPokemonDetail: GetPokemonDetail, loadingView: LoadingView, detailView: DetailView) {
        self.alertView = alertView
        self.getPokemonDetail = getPokemonDetail
        self.loadingView = loadingView
        self.detailView = detailView
    }
    
    public func getDetail(_ url: String) -> Void? {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getPokemonDetail.get(url: URL(string: url)!) { [weak self]
            result in
            self!.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure: self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                   do {
                        let pokemons = try result.get().toData()
                        self!.detailViewModel = try JSONDecoder().decode(DetailViewModel.self, from: pokemons!)
                        self!.detailView.presentList(viewModel: self!.detailViewModel)
                    } catch {
                        self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                    }
                }
        }
        return nil
    }
    
    public func getSpecie(_ url: String) -> Void? {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getPokemonDetail.getSpecie(url: URL(string: url)!) { [weak self]
            result in
            self!.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure: self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                   do {
                        let pokemons = try result.get().toData()
                        self!.specieDetailViewModel = try JSONDecoder().decode(SpecieDetailViewModel.self, from: pokemons!)
                        self!.detailView.presentSpecie(viewModel: self!.specieDetailViewModel)
                    } catch {
                        self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                    }
                }
        }
        return nil
    }
    
    public func getEvolution(_ url: String) -> Void? {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getPokemonDetail.getEvolution(url: URL(string: url)!) { [weak self]
            result in
            self!.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure: self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                   do {
                        let pokemons = try result.get().toData()
                        self!.evolutionChainViewModel = try JSONDecoder().decode(EvolutionChainDetailViewModel.self, from: pokemons!)
                        self!.detailView.presentEvolution(viewModel: self!.evolutionChainViewModel)
                    } catch {
                        self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                    }
                }
        }
        return nil
    }
    
}
