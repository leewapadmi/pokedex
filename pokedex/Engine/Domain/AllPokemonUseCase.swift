//
//  PokemonRepository.swift
//  pokedex
//
//  Created by Lee Wilson on 19/01/2024.
//

import Foundation
import Combine
import SwiftyMocky

//sourcery: AutoMockable
protocol AllPokemonUseCase {
    func getAllPokemon() -> AnyPublisher<[PokemonDetails], Error>
}

class AllPokemonUseCaseImpl : AllPokemonUseCase {
    
    private let pokemonApi: PokemonApi
    
    init(pokemonApi: PokemonApi) {
        self.pokemonApi = pokemonApi
    }
    
    func getAllPokemon() -> AnyPublisher<[PokemonDetails], Error> {
        return pokemonApi.getAllPokemon()
            .flatMap { listAllResponse in
                let ids = listAllResponse.results.enumerated()
                    .map { (index, item) in "\(index + 1)" }
                return self.getPokemonDetailsList(for: ids)
            }
            .eraseToAnyPublisher()
    }
    
    private func getPokemonDetailsList(
        for ids: [String]
    ) -> AnyPublisher<[PokemonDetails], Error> {
        return Publishers.MergeMany(
            ids.map { id in getPokemonDetail(with: id) }
        ).collect().eraseToAnyPublisher()
    }
    
    private func getPokemonDetail(
        with id: String
    ) -> AnyPublisher<PokemonDetails, Error> {
        return pokemonApi.getPokemon(with: id)
            .eraseToAnyPublisher()
    }
}
