//
//  PokemonDetails.swift
//  pokedex
//
//  Created by Lee Wilson on 04/02/2024.
//

import Foundation

struct PokemonDetails : Decodable, Equatable {
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
    let types: [PokemonType]
    let stats: [PokemonBaseStat]
}

struct PokemonBaseStat : Decodable, Equatable {
    let base_stat: Int
    let effort: Int
    let stat: PokemonBaseStatInfo
}

struct PokemonBaseStatInfo : Decodable, Equatable {
    let name: String
}

struct PokemonType : Decodable, Equatable {
    let slot: Int
    let type: PokemonTypeInfo
}

struct PokemonTypeInfo : Decodable, Equatable {
    let name: String
}

struct PokemonForm : Decodable, Equatable {
    let name: String
    let url: String
}

struct GameIndex : Decodable, Equatable {
    let game_index: Int
    let version: GameIndexVersion
}

struct GameIndexVersion : Decodable, Equatable {
    let name: String
    let url: String
}

struct Ability : Decodable, Equatable {
    let is_hidden: Bool
    let slot: Int
    let ability: AbilityDetails
}

struct AbilityDetails : Decodable, Equatable {
    let name: String
    let url: String
}

struct PokemonDetailsSprites : Decodable, Equatable {
    let front_default: String
    let other: OtherSprites
}

struct OtherSprites : Decodable, Equatable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork : Decodable, Equatable {
    let front_default: String
}
