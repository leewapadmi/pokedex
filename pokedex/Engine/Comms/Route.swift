//
//  Route.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation

enum Route {
    case getAllPokemon
    case getPokemonDetails(id: String)
    
    var url: URL {
        switch self {
        case .getAllPokemon:
            return URL(string: Route.baseUrl + "pokemon")!
        case .getPokemonDetails(let id):
            return URL(string: Route.baseUrl + "pokemon/\(id)")!
        }
    }
    
    static let baseUrl = "https://pokeapi.co/api/v2/"
}
