//
//  Pokemon.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation

struct PokemonDto : Codable {
    let name: String
    let url: String
}

struct ListAllPokemonResponse : Codable {
    let results: [PokemonDto]
}

struct Pokemon {
    let number: Int
    let url: String
    let imageUrl: String
    let name: String
}
