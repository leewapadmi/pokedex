//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Lee Wilson on 24/06/2024.
//

import UIKit
import Combine

final class PokemonDetailViewController : UIViewController, Storyboarded {
    
    var pokemonId: Int!
    var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        print("Entered new VC with id: \(pokemonId!)")
    }
}
