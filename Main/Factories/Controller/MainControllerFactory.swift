import Foundation
import UI
import Presentation
import Domain

public func makeMainController(getPokemons: GetPokemons) -> MainViewController {
    let controller = MainViewController.instantiate()
    let presenter = MainPresenter(alertView: WeakVarProxy(controller), getPokemons: getPokemons, loadingView: WeakVarProxy(controller), mainView: controller)
    controller.get = presenter.get
    return controller
}
