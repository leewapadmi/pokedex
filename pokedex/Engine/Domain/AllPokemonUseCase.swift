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
    func getAllPokemon() -> AnyPublisher<[Pokemon], AllPokemonError>
}

class AllPokemonUseCaseImpl : AllPokemonUseCase {
    
    private let pokemonApi: PokemonApi
    private var cachedPokemon: [Pokemon] = []
    
    init(pokemonApi: PokemonApi) {
        self.pokemonApi = pokemonApi
    }
    
    func getAllPokemon() -> AnyPublisher<[Pokemon], AllPokemonError> {
        return pokemonApi.getAllPokemon()
            .map { response in
                let pokemon = self.extractPokemonFromResponse(response: response)
                if !pokemon.isEmpty {
                    self.cachedPokemon = pokemon
                }
                return pokemon
            }
            .mapError { err in .networkError }
            .eraseToAnyPublisher()
    }
    
    private func extractPokemonFromResponse(
        response: ListAllPokemonResponse
    ) -> [Pokemon] {
        return response.results.map { dto in
            Pokemon(number: 1, url: dto.url, imageUrl: "", name: dto.name)
        }
    }
}
