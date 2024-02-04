//
//  Pokemon.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation

struct PokemonShort : Codable {
    let name: String
    let url: String
}

struct ListAllPokemonResponse : Codable {
    let results: [PokemonShort]
}
