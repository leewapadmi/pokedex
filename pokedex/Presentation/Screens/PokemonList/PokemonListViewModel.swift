//
//  PokemonListPresenter.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation
import Combine

enum PokemonListState {
    case loading
    case success(_ pokemons: [Pokemon])
    case loadError
}

final class PokemonListViewModel {
    
    private let allPokemonUseCase: AllPokemonUseCase
    
    init(allPokemonUseCase: AllPokemonUseCase) {
        self.allPokemonUseCase = allPokemonUseCase
    }
    
    private var _state = CurrentValueSubject<PokemonListState, Never>(.loading)
    lazy var state: AnyPublisher<PokemonListState, Never> = _state.eraseToAnyPublisher()
    
    private var cancellables: [AnyCancellable] = []
    
    func fetchData() {
        if case PokemonListState.success(_) = _state.value {
            return
        }
        
        allPokemonUseCase.getAllPokemon()
            .sinkMain { [weak self] completion in
                if case let .failure(error) = completion {
                    self?._state.send(.loadError)
                }
            } receiveValue: { [weak self] pokemon in
                self?._state.send(.success(pokemon))
            }.store(in: &cancellables)
    }
}
