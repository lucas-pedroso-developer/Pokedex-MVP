import Foundation
import Domain

public final class MainPresenter {
    private let alertView: AlertView
    private let getPokemons: GetPokemons
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, getPokemons: GetPokemons, loadingView: LoadingView) {
        self.alertView = alertView
        self.getPokemons = getPokemons
        self.loadingView = loadingView
    }
    
    public func get(viewModel: MainViewModel) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        
        getPokemons.get(url: URL(string: "")!) { [weak self]
            result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
            }
        }
    }
    
    /*public func get(viewModel: MainViewModel) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self]
            result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
            }
        }
    }*/
    
}
