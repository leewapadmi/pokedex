//
//  PokemonListPresenter.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation
import Combine

enum PokemonListState : Equatable {
    case loading
    case success(_ pokemons: [PokemonDetails])
    case loadError
}

enum SortByOption {
    case number
    case name
}

final class PokemonListViewModel {
    
    private let allPokemonUseCase: AllPokemonUseCase
    
    init(allPokemonUseCase: AllPokemonUseCase) {
        self.allPokemonUseCase = allPokemonUseCase
    }
    
    private var sortByOption: SortByOption = .number
    private var _state = CurrentValueSubject<PokemonListState, Never>(.loading)
    private var pokemon: [PokemonDetails] = []
    private var cancellables: [AnyCancellable] = []
    
    lazy var state: AnyPublisher<PokemonListState, Never> = _state.eraseToAnyPublisher()

    func fetchData() {
        if case PokemonListState.success(_) = _state.value {
            return
        }
        
        allPokemonUseCase.getAllPokemon()
            .sinkMain { [weak self] completion in
                if case .failure(_) = completion {
                    self?._state.send(.loadError)
                }
            } receiveValue: { [weak self] pokemon in
                self?.pokemon = pokemon
                self?.sortAndEmit(items: pokemon)
            }.store(in: &cancellables)
    }
    
    private func sortAndEmit(items: [PokemonDetails]) {
        var results: [PokemonDetails] = []
        switch (sortByOption) {
        case .name:
            results = items.sorted { $0.name < $1.name }
        case .number:
            results = items.sorted { $0.id < $1.id }
        }
        _state.send(.success(results))
    }
    
    func filterResults(searchTerm: String) {
        if (searchTerm.isEmpty) {
            sortAndEmit(items: pokemon)
            return
        }
        
        let filteredItems = pokemon.filter { item in
            item.name.lowercased()
                .contains(searchTerm.lowercased())
        }
        sortAndEmit(items: filteredItems)
    }
    
    func changeSortByOption(option: SortByOption) {
        sortByOption = option
        sortAndEmit(items: pokemon)
    }
}
