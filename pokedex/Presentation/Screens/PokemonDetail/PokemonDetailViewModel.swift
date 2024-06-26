//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Lee Wilson on 26/06/2024.
//

import Combine

enum PokemonDetailState : Equatable {
    case loading
    case finishedLoading(description: String?)
}

final class PokemonDetailViewModel {
    
    private let pokemonDetailUseCase: PokemonDetailUseCase!
    
    init(pokemonDetailUseCase: PokemonDetailUseCase!) {
        self.pokemonDetailUseCase = pokemonDetailUseCase
    }
    
    private var cancellables: [AnyCancellable] = []
    private var _state = CurrentValueSubject<PokemonDetailState, Never>(.loading)
    lazy var state: AnyPublisher<PokemonDetailState, Never> = _state.eraseToAnyPublisher()
    
    func loadDescription(id: String) {
        pokemonDetailUseCase.getPokemonDescription(id: id)
            .sinkMain { [weak self] completion in
                if case .failure(_) = completion {
                    print("we got an error!")
                    self?._state.send(.finishedLoading(description: nil))
                }
            } receiveValue: { [weak self] description in
                self?._state.send(.finishedLoading(description: description))
            }.store(in: &cancellables)
    }
}
