//
//  Coordinator.swift
//  pokedex
//
//  Created by Lee Wilson on 28/01/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

