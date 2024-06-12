//
//  PokemonDetails.swift
//  pokedex
//
//  Created by Lee Wilson on 04/02/2024.
//

import Foundation

struct PokemonDetails : Decodable {
    let name: String
    let id: Int
    let order: Int
    let weight: Int
    let height: Int
    let is_default: Bool
    let base_experience: Int
    let abilities: [Ability]
    let forms: [PokemonForm]
    let game_indices: [GameIndex]
    let sprites: PokemonDetailsSprites
}

struct PokemonForm : Decodable {
    let name: String
    let url: String
}

struct GameIndex : Decodable {
    let game_index: Int
    let version: GameIndexVersion
}

struct GameIndexVersion : Decodable {
    let name: String
    let url: String
}

struct Ability : Decodable {
    let is_hidden: Bool
    let slot: Int
    let ability: AbilityDetails
}

struct AbilityDetails : Decodable {
    let name: String
    let url: String
}

struct PokemonDetailsSprites : Decodable {
    let front_default: String
    let other: OtherSprites
}

struct OtherSprites : Decodable {
    let official_artwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case official_artwork = "official-artwork"
    }
}

struct OfficialArtwork : Decodable {
    let front_default: String
}
