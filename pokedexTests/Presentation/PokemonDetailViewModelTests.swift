//
//  PokemonDetailViewModelTests.swift
//  pokedexTests
//
//  Created by Lee Wilson on 26/06/2024.
//

import XCTest
import Foundation
import SnapshotTesting
import Combine
import SwiftyMocky

@testable import pokedex

final class PokemonDetailViewModelTests : XCTestCase {
    
    var sut: PokemonDetailViewModel!
    let pokemonDetailUseCaseMock = PokemonDetailUseCaseMock()
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        sut = PokemonDetailViewModel(pokemonDetailUseCase: pokemonDetailUseCaseMock)
    }
    
    func test_initialState_loading() {
        expectPublished(
            output: PokemonDetailState.loading,
            from: sut.state,
            storeIn: &cancellables
        ) {}
    }
    
    func test_useCaseReturnsSuccess_returnDesc() {
        let expectedDescr = "This is a description"
        Given(
            pokemonDetailUseCaseMock,
            .getPokemonDescription(
                id: .any,
                willReturn: Just(expectedDescr)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        
        sut.loadDescription(id: "1")
        
        expectPublished(
            output: PokemonDetailState.finishedLoading(description: expectedDescr),
            from: sut.state,
            dropFirst: 1,
            storeIn: &cancellables
        ) {}
    }
    
    func test_useCaseReturnsSuccessButNil_returnNil() {
        let expectedDescr: String? = nil
        Given(
            pokemonDetailUseCaseMock,
            .getPokemonDescription(
                id: .any,
                willReturn: Just(nil)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        
        sut.loadDescription(id: "1")
        
        expectPublished(
            output: PokemonDetailState.finishedLoading(description: expectedDescr),
            from: sut.state,
            dropFirst: 1,
            storeIn: &cancellables
        ) {}
    }
    
    func test_useCaseReturnsFailure_returnNil() {
        let expectedDescr: String? = nil
        Given(
            pokemonDetailUseCaseMock,
            .getPokemonDescription(
                id: .any,
                willReturn: Fail(error: ApiError.generalNetworkError)
                    .eraseToAnyPublisher()
            )
        )
        
        sut.loadDescription(id: "1")
        
        expectPublished(
            output: PokemonDetailState.finishedLoading(description: expectedDescr),
            from: sut.state,
            dropFirst: 1,
            storeIn: &cancellables
        ) {}
    }
}
