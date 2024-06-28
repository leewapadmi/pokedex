//
//  Theme.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import Foundation
import UIKit

let primaryColor = UIColor(hex: "#DC0A2D")
let onPrimaryColor = UIColor(hex: "#FFFFFF")
let greyText = UIColor(hex: "#666666")
let greyBackground = UIColor(hex: "#EFEFEF")

// species colors
let bugColor = UIColor(hex: "#A7B723")
let darkColor = UIColor(hex: "#75574C")
let dragonColor = UIColor(hex: "#7037FF")
let electricColor = UIColor(hex: "#F9CF30")
let fairyColor = UIColor(hex: "#E69EAC")
let fightingColor = UIColor(hex: "#C12239")
let fireColor = UIColor(hex: "#F57D31")
let flyingColor = UIColor(hex: "#A891EC")
let ghostColor = UIColor(hex: "#70559B")
let normalColor = UIColor(hex: "#AAA67F")
let grassColor = UIColor(hex: "#74CB48")
let groundColor = UIColor(hex: "#DEC16B")
let iceColor = UIColor(hex: "#9AD6DF")
let poisonColor = UIColor(hex: "#A43E9E")
let psychicColor = UIColor(hex: "#FB5584")
let rockColor = UIColor(hex: "#B69E31")
let steelColor = UIColor(hex: "#B7B9D0")
let waterColor = UIColor(hex: "#6493EB")

extension PokemonType {
    var symbolicColor: UIColor {
        switch self {
        case .bug:
            bugColor
        case .dark:
            darkColor
        case .dragon:
            dragonColor
        case .electric:
            electricColor
        case .fairy:
            fairyColor
        case .fighting:
            fightingColor
        case .fire:
            fireColor
        case .flying:
            flyingColor
        case .ghost:
            ghostColor
        case .normal:
            normalColor
        case .grass:
            grassColor
        case .ground:
            groundColor
        case .ice:
            iceColor
        case .poison:
            poisonColor
        case .psychic:
            psychicColor
        case .rock:
            rockColor
        case .steel:
            steelColor
        case .water:
            waterColor
        }
    }
}
