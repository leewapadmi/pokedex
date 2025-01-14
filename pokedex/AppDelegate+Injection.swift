//
//  AppDelegate+Injection.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation
import Resolver

extension Resolver : ResolverRegistering {
    public static func registerAllServices() {
        
        // register core services
        register(CommsSession.self) { CommsSessionImpl() }.scope(.application)
        
        // register apis
        register(PokemonApi.self) { PokemonApiImpl(session: resolve()) }
        register(ImagePreloader.self) { ImagePreloaderImpl() }
        
        // register use cases
        register(AllPokemonUseCase.self) { AllPokemonUseCaseImpl(pokemonApi: resolve(), imagePreloader: resolve()) }
        register(PokemonDetailUseCase.self) { PokemonDetailUseCaseImpl(pokemonApi: resolve()) }
        
        // register VMs
        register(PokemonListViewModel.self) { PokemonListViewModel(allPokemonUseCase: resolve()) }
        register(PokemonDetailViewModel.self) { PokemonDetailViewModel(pokemonDetailUseCase: resolve()) }
    }
}
