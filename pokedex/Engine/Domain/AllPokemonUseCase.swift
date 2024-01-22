//
//  PokemonRepository.swift
//  pokedex
//
//  Created by Lee Wilson on 19/01/2024.
//

import Foundation
import Combine

enum AllPokemonError : Error {
    case networkError
}

protocol AllPokemonUseCase {
//    func getAllPokemon() -> AnyPublisher<[Pokemon], AllPokemonError>
}

class AllPokemonUseCaseImpl : AllPokemonUseCase {
//    func getAllPokemon() -> AnyPublisher<[Pokemon], AllPokemonError> {
//        return Fail(error: .networkError)
//    }
    
    
    private let pokemonApi: PokemonApi
    
    init(pokemonApi: PokemonApi) {
        self.pokemonApi = pokemonApi
    }
}
