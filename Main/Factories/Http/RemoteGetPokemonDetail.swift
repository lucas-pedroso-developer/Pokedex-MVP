import Foundation
import Data
import Domain

func makeRemoteGetPokemonDetail(url: URL, httpClient: HttpGetClient) -> GetPokemonDetail {
    let remoteGetPokemonDetail = RemoteGetPokemonDetail(url: url, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteGetPokemonDetail)
}
