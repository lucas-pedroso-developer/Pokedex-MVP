import Foundation
import UI
import Presentation
import Domain

public func makeDetailController(getPokemonDetail: GetPokemonDetail) -> DetailViewController {
    let controller = DetailViewController.instantiate()
    let presenter = DetailPresenter(alertView: WeakVarProxy(controller), getPokemonDetail: getPokemonDetail, loadingView: WeakVarProxy(controller), detailView: controller)
    controller.getDetail = presenter.getDetail
    controller.getSpecie = presenter.getSpecie
    controller.getEvolution = presenter.getEvolution
    return controller
}
