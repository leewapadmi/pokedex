//
//  AllPokemonResponse.swift
//  pokedexTests
//
//  Created by Lee Wilson on 25/06/2024.
//

@testable import pokedex

extension ListAllPokemonResponse {
    static let mock = ListAllPokemonResponse(
        results: [PokemonShort.mock, PokemonShort.mock, PokemonShort.mock]
    )
}

extension PokemonShort {
    static let mock = PokemonShort(
        name: "Pikachu",
        url: "http://myurl.com/pikachu"
    )
}
