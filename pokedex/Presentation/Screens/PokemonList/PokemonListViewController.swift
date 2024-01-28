//
//  ViewController.swift
//  pokedex
//
//  Created by Lee Wilson on 02/01/2024.
//

import UIKit
import Combine
import Resolver

class PokemonListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var viewModel: PokemonListViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var pokemon: [Pokemon] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = primaryColor
        loadingSpinner.color = onPrimaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewModel?.fetchData()
        subscribeObservers()
    }
    
    private func subscribeObservers() {
        viewModel.state.sinkMain { [weak self] state in
            self?.handleState(state: state)
        }.store(in: &cancellables)
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
    
    private func showSuccessState(pokemon: [Pokemon]) {
        self.pokemon = pokemon
        tableView.reloadData()
        tableView.isHidden = false
        loadingSpinner.isHidden = true
    }
    
    private func showLoading() {
        tableView.isHidden = true
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
    }
}

extension PokemonListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension PokemonListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = pokemon[indexPath.row].name
        return cell
    }
}
