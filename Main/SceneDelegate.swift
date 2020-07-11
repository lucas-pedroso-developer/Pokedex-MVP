import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let mainFactory: () -> MainViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        return makeMainController(getPokemons: makeRemoteGetPokemons(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!, httpClient: alamofireAdapter))
    }
    
    private let detailFactory: () -> DetailViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        return makeDetailController(getPokemonDetail: makeRemoteGetPokemonDetail(url: URL(string: "https://pokeapi.co/api/v2/pokemon/1")!, httpClient: alamofireAdapter))
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mainController = mainFactory()
        let detailViewController = detailFactory()
        mainController.detailViewController = detailViewController
        window?.rootViewController = mainController
        window?.makeKeyAndVisible()
        
    }
}

