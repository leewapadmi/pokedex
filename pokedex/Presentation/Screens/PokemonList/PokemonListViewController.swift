//
//  ViewController.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController, Storyboarded, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var topRowView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var viewModel: PokemonListViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var pokemonDataSource: [PokemonDetails] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = primaryColor
        loadingSpinner.color = onPrimaryColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.state.sinkMain { [weak self] state in
            self?.handleState(state: state)
        }.store(in: &cancellables)
        viewModel.fetchData()
    }
    
    @IBAction func editingDidChange(_ sender: UITextField) {
        if let searchTerm = sender.text {
            viewModel.filterResults(searchTerm: searchTerm)
        }
    }
    
    private func configureCollectionView() {
        collectionView.layer.cornerRadius = 16
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 24, left: 8, bottom: 24, right: 8)
        flow.minimumInteritemSpacing = 8
        flow.minimumLineSpacing = 8
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    private func handleState(state: PokemonListState) {
        switch state {
        case .loadError:
            print("Something went wrong!")
        case .success(let pokemon):
            showSuccessState(pokemon: pokemon)
        case .loading:
            showLoading()
        }
    }
    
    private func showSuccessState(pokemon: [PokemonDetails]) {
        self.pokemonDataSource = pokemon
        loadingSpinner.stopAnimating()
        loadingSpinner.isHidden = true
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    private func showLoading() {
        collectionView.isHidden = true
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        pokemonDataSource.count
    }

    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let pokemonListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PokemonListCell",
            for: indexPath
        ) as! PokemonListCollectionViewCell
        
        pokemonListCell.bind(with: pokemonDataSource[indexPath.row])
        return pokemonListCell
    }
}

extension PokemonListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let numberofItem: CGFloat = 3
        let collectionViewWidth = self.collectionView.bounds.width
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        return CGSize(width: width, height: width)
    }
}
