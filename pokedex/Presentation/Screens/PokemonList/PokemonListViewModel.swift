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
    
    func fetchData() {
        _state.value = .loading
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(
            with: URLRequest(url: url),
            completionHandler: { data, response, error in
                if error != nil {
                    self._state.value = .loadError
                } else {
                    let decoder = JSONDecoder()
                    guard let rawData = data else { return }
                    do {
                        let decodedResponse: ListAllPokemonResponse = try decoder.decode(
                            ListAllPokemonResponse.self,
                            from: rawData
                        )
                        
                        let results = decodedResponse.results.enumerated().map { (index, element) in
                            let number = index + 1
                            return Pokemon(
                                number: number,
                                url: element.url,
                                imageUrl: "https://raw.githubusercontent.com/" +
                                    "PokeAPI/sprites/master/sprites/pokemon/\(number).png",
                                name: element.name
                            )
                        }
                        
                        self._state.value = .success(results)
                    } catch {
                        self._state.value = .loadError
                    }
                }
            }
        ).resume()
    }
}
