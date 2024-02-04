//
//  PokemonListCollectionViewCell.swift
//  pokedex
//
//  Created by Lee Wilson on 30/01/2024.
//

import UIKit

class PokemonListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func bind(with pokemon: PokemonDetails) {
        nameLabel.text = pokemon.name
    }
}
