//
//  PokemonListCollectionViewCell.swift
//  pokedex
//
//  Created by Lee Wilson on 30/01/2024.
//

import UIKit
import Kingfisher

class PokemonListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    func bind(with pokemon: PokemonDetails) {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.125
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
        
        containerView.layer.cornerRadius = 8
        groundView.layer.cornerRadius = 8
        groundView.layer.backgroundColor = greyBackground.cgColor
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = getIdString(id: pokemon.id)
        idLabel.textColor = greyText
        let imgUrl = URL(string: pokemon.sprites.other.officialArtwork.front_default)
        imageView.kf.setImage(with: imgUrl)
    }
    
    private func getIdString(id: Int) -> String {
        let withLeading = String(format: "%03d", id)
        return "#\(withLeading)"
    }
}
