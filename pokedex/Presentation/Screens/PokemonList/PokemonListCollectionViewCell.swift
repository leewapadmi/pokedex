//
//  PokemonListCollectionViewCell.swift
//  pokedex
//
//  Created by Lee Wilson on 30/01/2024.
//

import UIKit
import Kingfisher

class PokemonListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func bind(with pokemon: PokemonDetails) {
        nameLabel.text = pokemon.name.capitalized
        nameLabel.textAlignment = .center
        let imgUrl = URL(string: pokemon.sprites.front_default)
        imageView.kf.setImage(with: imgUrl)
    }
}
