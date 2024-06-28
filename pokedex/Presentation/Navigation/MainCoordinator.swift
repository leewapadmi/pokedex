//
//  MainCoordinator.swift
//  pokedex
//
//  Created by Lee Wilson on 28/01/2024.
//

import Foundation
import UIKit
import Resolver

class MainCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PokemonListViewController.instantiate()
        viewController.viewModel = PokemonListViewModel(allPokemonUseCase: Resolver.resolve())
        viewController.coordinator = self
        navigationController.pushViewController(
            viewController,
            animated: false
        )
    }
    
    func showPokemonDetail(forPokemon pokemon: PokemonDetails) {
        let viewController = PokemonDetailViewController.instantiate()
        viewController.pokemon = pokemon
        viewController.coordinator = self
        viewController.viewModel = PokemonDetailViewModel(pokemonDetailUseCase: Resolver.resolve())
        navigationController.pushViewController(
            viewController,
            animated: true
        )
    }
}
