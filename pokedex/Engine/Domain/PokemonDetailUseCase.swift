//
//  PokemonDetailUseCase.swift
//  pokedex
//
//  Created by Lee Wilson on 25/06/2024.
//

import Combine

//sourcery: AutoMockable
protocol PokemonDetailUseCase {
    func getPokemonDescription(id: String) -> AnyPublisher<String?, Error>
}

final class PokemonDetailUseCaseImpl : PokemonDetailUseCase {
    
    let pokemonApi: PokemonApi
    
    init(pokemonApi: PokemonApi) {
        self.pokemonApi = pokemonApi
    }
    
    func getPokemonDescription(id: String) -> AnyPublisher<String?, Error> {
        return pokemonApi.getPokemonSpecies(with: id)
            .map { species in
                species.flavor_text_entries.first { entry in
                    entry.language.name == "en"
                }?.flavor_text
            }
            .eraseToAnyPublisher()
    }
}
