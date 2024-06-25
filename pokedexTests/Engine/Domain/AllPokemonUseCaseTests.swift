//
//  AllPokemonUseCaseTests.swift
//  pokedexTests
//
//  Created by Lee Wilson on 25/06/2024.
//

import XCTest
import Foundation
import SnapshotTesting
import SwiftyMocky
import Combine

@testable import pokedex

final class AllPokemonUseCaseTests: XCTestCase {
    
    var sut: AllPokemonUseCase!
    let imagePreloaderMock = ImagePreloaderMock()
    let pokemonApiMock = PokemonApiMock()
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        sut = AllPokemonUseCaseImpl(
            pokemonApi: pokemonApiMock,
            imagePreloader: imagePreloaderMock
        )
        Given(
            imagePreloaderMock,
            .preloadImages(
                rawUrls: .any,
                willReturn: Just(())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
    }
    
    func test_getAllPokemon_returnsSuccess() {
        Given(
            pokemonApiMock,
            .getAllPokemon(
                willReturn: Just(ListAllPokemonResponse.mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        Given(
            pokemonApiMock,
            .getPokemon(
                with: .any(String.self),
                willReturn: Just(PokemonDetails.mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        expectPublished(
            output: [PokemonDetails.mock, PokemonDetails.mock, PokemonDetails.mock],
            from: sut.getAllPokemon(),
            storeIn: &cancellables
        ) {}
        
        Verify(
            imagePreloaderMock,
            .exactly(1),
            .preloadImages(rawUrls: .any)
        )
    }
    
    func test_getAllPokemon_firstApiCallReturnsFailure() {
        Given(
            pokemonApiMock,
            .getAllPokemon(
                willReturn: Fail(error: RequestError.parseError)
                    .eraseToAnyPublisher()
            )
        )
        
        expectPublisherFailure(
            from: sut.getAllPokemon(),
            storeIn: &cancellables
        ) {}
        
        Verify(
            imagePreloaderMock,
            .never,
            .preloadImages(rawUrls: .any)
        )
        
        Verify(
            pokemonApiMock,
            .never,
            .getPokemon(with: .any)
        )
    }
    
    func test_getAllPokemon_chainedApiCallReturnsFailure() {
        Given(
            pokemonApiMock,
            .getAllPokemon(
                willReturn: Just(ListAllPokemonResponse.mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            )
        )
        Given(
            pokemonApiMock,
            .getPokemon(
                with: .any,
                willReturn: Fail(error: RequestError.parseError)
                    .eraseToAnyPublisher()
            )
        )
        
        expectPublisherFailure(
            from: sut.getAllPokemon(),
            storeIn: &cancellables
        ) {}
        
        Verify(
            imagePreloaderMock,
            .never,
            .preloadImages(rawUrls: .any)
        )
        
        Verify(
            pokemonApiMock,
            .exactly(ListAllPokemonResponse.mock.results.count),
            .getPokemon(with: .any)
        )
    }
}
