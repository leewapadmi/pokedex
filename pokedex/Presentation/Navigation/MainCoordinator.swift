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
        navigationController.pushViewController(
            viewController,
            animated: false
        )
    }
}
