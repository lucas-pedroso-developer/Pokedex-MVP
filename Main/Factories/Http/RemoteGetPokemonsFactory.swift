import Foundation
import Data
import Domain

func makeRemoteGetPokemons(url: URL, httpClient: HttpGetClient) -> GetPokemons {
    let remoteGetPokemons = RemoteGetPokemons(url: url, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteGetPokemons)
}
