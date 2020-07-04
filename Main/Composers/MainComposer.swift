import Foundation
import Domain
import UI
import Presentation
import Domain

public final class MainComposer {
    public static func composeControllerWith(getPokemons: GetPokemons) -> MainViewController {
        let controller = MainViewController.instantiate()
        let presenter = MainPresenter(alertView: WeakVarProxy(controller), getPokemons: getPokemons, loadingView: WeakVarProxy(controller), mainView: controller)
        controller.get = presenter.get
        return controller
    }
}
