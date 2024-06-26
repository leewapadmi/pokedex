//
//  PokemonSpecies.swift
//  pokedex
//
//  Created by Lee Wilson on 26/06/2024.
//

struct PokemonSpecies : Decodable {
    let flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry : Decodable {
    let flavor_text: String
    let language: FlavorTextLanguageInfo
}

struct FlavorTextLanguageInfo : Decodable {
    let name: String
}
