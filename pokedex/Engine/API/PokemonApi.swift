//
//  PokemonApi.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation
import Combine

protocol PokemonApi {
    func getAllPokemon() -> AnyPublisher<ListAllPokemonResponse, Error>
    func getPokemon(with id: String) -> AnyPublisher<PokemonDetails, Error>
}

class PokemonApiImpl : BaseApi, PokemonApi {
    func getAllPokemon() -> AnyPublisher<ListAllPokemonResponse, Error> {
        let params = ["limit": "151"]
        let req = JSONRequest(route: Route.getAllPokemon, params: params)
        return session.request(ListAllPokemonResponse.self, req)
    }
    
    func getPokemon(with id: String) -> AnyPublisher<PokemonDetails, Error> {
        print("getting pokemon with id: \(id)")
        let req = JSONRequest(route: Route.getPokemonDetails(id: id))
        return session.request(PokemonDetails.self, req)
    }
}
