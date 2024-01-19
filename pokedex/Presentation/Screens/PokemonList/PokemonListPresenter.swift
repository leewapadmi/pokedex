//
//  PokemonListPresenter.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation
import Combine

enum PokemonListState : Equatable {
    case loaded(_ pokemons: [Pokemon])
}

protocol PokemonListPresenter {
    var state: AnyPublisher<PokemonListState, Never> { get }
    
    func loadPokemon()
}

class PokemonListPresenterImpl
