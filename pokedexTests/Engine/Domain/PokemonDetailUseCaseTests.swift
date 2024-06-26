//
//  PokemonDetailUseCaseTests.swift
//  pokedexTests
//
//  Created by Lee Wilson on 25/06/2024.
//

import XCTest
import SwiftyMocky
import Combine
import SnapshotTesting

@testable import pokedex

final class PokemonDetailUseCaseTests: XCTestCase {
    
    var sut: PokemonDetailUseCase!
    private let apiMock = PokemonApiMock()
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        sut = PokemonDetailUseCaseImpl(pokemonApi: apiMock)
    }
    
    func test_apiReturnsSuccess_returnDescription() {
        Given(
            apiMock,
            .getPokemonSpecies(
                with: .any,
                willReturn: Just(PokemonSpecies.mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        
        expectPublished(
            output: "This is a flavor text",
            from: sut.getPokemonDescription(id: "1"),
            storeIn: &cancellables
        ) {}
    }
    
    func test_apiReturnsFailure_returnFailure() {
        Given(
            apiMock,
            .getPokemonSpecies(
                with: .any,
                willReturn: Fail(error: RequestError.parseError)
                    .eraseToAnyPublisher()
            )
        )
        
        expectPublisherFailure(
            from: sut.getPokemonDescription(id: "1"),
            storeIn: &cancellables
        ) {}
    }
}
