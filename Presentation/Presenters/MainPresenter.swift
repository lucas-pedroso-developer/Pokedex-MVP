import Foundation
import Domain
import UIKit

public final class MainPresenter {
    private let alertView: AlertView
    private let getPokemons: GetPokemons
    private let loadingView: LoadingView
    private var mainViewModel: MainViewModel?
    private var mainView: MainView
    
    public init(alertView: AlertView, getPokemons: GetPokemons, loadingView: LoadingView, mainView: MainView) {
        self.alertView = alertView
        self.getPokemons = getPokemons
        self.loadingView = loadingView
        self.mainView = mainView
    }
    
    public func get(_ url: String) -> Void? {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getPokemons.get(url: URL(string: url)!) { [weak self]
            result in
            self!.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure: self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success:
                   do {
                        let pokemons = try result.get().toData()
                        self!.mainViewModel = try JSONDecoder().decode(MainViewModel.self, from: pokemons!)
                        self!.mainView.presentList(viewModel: self!.mainViewModel)
                    } catch {
                        self!.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                    }
                }
        }
        return nil
    }
}

public protocol CollectionViewProtocol {
    func renderList(viewModel: MainViewModel)
}
