//
//  PokemonListViewModelTests.swift
//  pokedexTests
//
//  Created by Lee Wilson on 20/06/2024.
//

import XCTest
import Foundation
import SnapshotTesting
import Combine
import SwiftyMocky

@testable import pokedex

final class PokemonListViewModelTests: XCTestCase {

    var sut: PokemonListViewModel!
    let allPokemonUseCase = AllPokemonUseCaseMock()
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        sut = PokemonListViewModel(
            allPokemonUseCase: allPokemonUseCase
        )
    }
    
    func test_initialState() {
        expectPublished(
            output: PokemonListState.loading,
            from: sut.state,
            storeIn: &cancellables
        ) {}
    }
    
    func test_fetchData_returnsResults() {
        let expectedResults = PokemonDetails.mockList
        Given(
            allPokemonUseCase,
            .getAllPokemon(
                willReturn: Just<[PokemonDetails]>(expectedResults)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        
        sut.fetchData()
        
        expectPublished(
            output: PokemonListState.success(expectedResults),
            from: sut.state,
            dropFirst: 1,
            storeIn: &cancellables
        ) {}
    }
    
    func test_fetchData_returnsError() {
        Given(
            allPokemonUseCase,
            .getAllPokemon(
                willReturn: Fail(error: ApiError.generalNetworkError)
                    .eraseToAnyPublisher()
            )
        )
        
        sut.fetchData()
        
        expectPublished(
            output: PokemonListState.loadError,
            from: sut.state,
            dropFirst: 1,
            storeIn: &cancellables
        ) {}
    }
}
