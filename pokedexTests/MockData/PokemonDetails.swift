//
//  PokemonDetails.swift
//  pokedexTests
//
//  Created by Lee Wilson on 24/06/2024.
//

import Foundation
@testable import pokedex

extension PokemonDetails {
    static let mock = PokemonDetails(
        name: "Pikachu", id: 1, order: 1, weight: 1, height: 2, is_default: true, base_experience: 23, abilities: [], forms: [], game_indices: [], sprites: PokemonDetailsSprites(front_default: "", other: OtherSprites(official_artwork: OfficialArtwork(front_default: ""))))
    
    static let mockList = [
        mock,
        mock,
        mock
    ]
}
