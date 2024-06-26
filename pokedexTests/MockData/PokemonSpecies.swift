//
//  PokemonSpecies.swift
//  pokedexTests
//
//  Created by Lee Wilson on 26/06/2024.
//

@testable import pokedex

extension PokemonSpecies {
    static let mock = PokemonSpecies(
        flavor_text_entries: [
            FlavorTextEntry(
                flavor_text: "This is a flavor text",
                language: FlavorTextLanguageInfo(name: "en")
            )
        ]
    )
}
