//
//  Route.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation

enum Route {
    case getAllPokemon
    
    var url: URL {
        switch self {
        case .getAllPokemon:
            return URL(string: Route.baseUrl + "pokemon")!
        }
    }
    
    static let baseUrl = "https://pokeapi.co/api/v2/"
}
