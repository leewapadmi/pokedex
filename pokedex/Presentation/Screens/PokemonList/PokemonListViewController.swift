//
//  ViewController.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = primaryColor
        loadingSpinner.color = onPrimaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
    }
    
    private func showLoading() {
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
    }
    
    private func showError() {
        
    }
    
    private func showLoadedContent() {
        
    }
}

