//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Lee Wilson on 24/06/2024.
//

import UIKit
import Combine

final class PokemonDetailViewController : UIViewController, Storyboarded {
    
    var pokemon: PokemonDetails!
    var coordinator: MainCoordinator!
    var viewModel: PokemonDetailViewModel!
    private var cancellables: [AnyCancellable] = []
    
    private lazy var bottomStackParentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.spacing = 18
        view.axis = .vertical
        return view
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .medium
        return view
    }()
    
    override func viewDidLoad() {
        setupViews()
        subscribeObservers()
    }
    
    private func setupViews() {
        if let type = pokemon.types.first {
            view.backgroundColor = type.type.name.symbolicColor
        }
        self.navigationController?.isNavigationBarHidden = true
        
        setupBackgroundPokeballImage()
        setupTopRow()
        setupBottomSection()
        setupArtwork()
    }
    
    private func setupBottomSection() {
        bottomStackParentView.addSubview(bottomStackView)
        bottomStackView.leadingAnchor.constraint(equalTo: bottomStackParentView.leadingAnchor, constant: 12).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: bottomStackParentView.trailingAnchor, constant: -12).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: bottomStackParentView.topAnchor, constant: 56).isActive = true
        bottomStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomStackParentView.bottomAnchor, constant: -12).isActive = true
        view.addSubview(bottomStackParentView)
        
        bottomStackParentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        bottomStackParentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        bottomStackParentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 224).isActive = true
        bottomStackParentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        bottomStackParentView.addSubview(loadingSpinner)
        loadingSpinner.centerXAnchor.constraint(equalTo: bottomStackParentView.centerXAnchor).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: bottomStackParentView.centerYAnchor).isActive = true
        loadingSpinner.isHidden = true
    }
    
    private func populateBottomStackView(description: String?) {
        bottomStackView.addArrangedSubview(makeTypesRow())
        bottomStackView.addArrangedSubview(makeBottomSectionHeadingLabel(withText: "About"))
        bottomStackView.addArrangedSubview(makeThreeColumnRow())
        if let descriptionNotNil = description {
            let descriptionView = makeDescriptionLabel(description: descriptionNotNil)
            bottomStackView.addArrangedSubview(descriptionView)
            descriptionView.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 12).isActive = true
            descriptionView.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: -12).isActive = true
        }
        bottomStackView.addArrangedSubview(makeBottomSectionHeadingLabel(withText: "Base Stats"))
        let statsTable = makeBaseStatsTable()
        bottomStackView.addArrangedSubview(statsTable)
        statsTable.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 12).isActive = true
        statsTable.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: -12).isActive = true
    }
    
    private func makeBaseStatsTable() -> UIStackView {
        let verticalStack = UIStackView()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        verticalStack.spacing = 0
        let data = pokemon.formattedStats
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "hp"))
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "attack"))
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "defense"))
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "special-attack"))
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "special-defense"))
        verticalStack.addArrangedSubview(makeBaseStatsTableRow(data: data, category: "speed"))
        return verticalStack
    }
    
    private func makeBaseStatsTableRow(data: [String : String], category: String) -> UIView {
        let entryOptional = data.filter { $0.key == category }.first
        if let entry = entryOptional {
            let row = UIStackView()
            row.axis = .horizontal
            row.translatesAutoresizingMaskIntoConstraints = false
            row.spacing = 8
            row.alignment = .center
            
            let categoryLabel = UILabel()
            categoryLabel.text = getBaseStatLabelText(from: entry.key)
            categoryLabel.textColor = pokemon.types.first?.type.name.symbolicColor
            categoryLabel.font = UIFont(name: "poppins", size: CGFloat(12))
            categoryLabel.textAlignment = .right
            categoryLabel.translatesAutoresizingMaskIntoConstraints = false
            categoryLabel.widthAnchor.constraint(equalToConstant: CGFloat(32)).isActive = true
            row.addArrangedSubview(categoryLabel)
            
            let divider = UIView()
            divider.backgroundColor = UIColor(hex: "#666666", alpha: CGFloat(0.2))
            divider.widthAnchor.constraint(equalToConstant: CGFloat(2)).isActive = true
            divider.heightAnchor.constraint(equalToConstant: CGFloat(28)).isActive = true
            divider.setContentHuggingPriority(.defaultLow, for: . vertical)
            divider.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            row.addArrangedSubview(divider)
            
            let valueLabel = UILabel()
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.text = entry.value
            valueLabel.font = UIFont(name: "poppins", size: CGFloat(12))
            valueLabel.textAlignment = .left
            row.addArrangedSubview(valueLabel)
            
            let progressView = UIProgressView(progressViewStyle: .default)
            let progressValue = Float(entry.value)! / Float(floatLiteral: 200)
            progressView.progress = progressValue
            progressView.progressTintColor = pokemon.types.first?.type.name.symbolicColor
            row.addArrangedSubview(progressView)
            
            return row
        }
        print("Category \"\(category)\" not found. Ignoring...")
        return UIView()
    }
    
    private func getBaseStatLabelText(from description: String) -> String {
        switch description {
        case "hp":
            return "HP"
        case "attack":
            return "ATK"
        case "defense":
            return "DEF"
        case "special-attack":
            return "SATK"
        case "special-defense":
            return "SDEF"
        case "speed":
            return "SPD"
        default:
            return "???"
        }
    }
    
    private func makeDescriptionLabel(description: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = description
        label.font = UIFont(name: "poppins", size: CGFloat(12))
        label.textColor = .black
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        return label
    }
    
    private func makeBottomSectionHeadingLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: "poppins", size: CGFloat(17))
        label.textColor = pokemon.types.first?.type.name.symbolicColor
        return label
    }
    
    private func makeTypesRow() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        pokemon.types.forEach { typeInfo in
            let parentView = UIView()
            parentView.translatesAutoresizingMaskIntoConstraints = false
        
            let typeLabel = UILabel()
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.textColor = .white
            typeLabel.font = UIFont(name: "poppins", size: CGFloat(12))
            typeLabel.text = typeInfo.type.name.rawValue.localizedCapitalized
            
            parentView.backgroundColor = typeInfo.type.name.symbolicColor
            parentView.layer.cornerRadius = 10
            parentView.addSubview(typeLabel)
            typeLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8).isActive = true
            typeLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8).isActive = true
            typeLabel.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 2).isActive = true
            typeLabel.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -2).isActive = true
            parentView.setContentHuggingPriority(.required, for: .horizontal)
            typeLabel.setContentHuggingPriority(.required, for: .horizontal)
            stackView.addArrangedSubview(parentView)
        }
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        return stackView
    }
    
    private func setupArtwork() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        let url = URL(string: pokemon.sprites.other.officialArtwork.front_default)
        imageView.kf.setImage(with: url)
    }
    
    private func setupBackgroundPokeballImage() {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 208).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 208).isActive = true
        imageView.image = UIImage(named: "pokeball_background")
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    private func setupTopRow() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.addArrangedSubview(backButton)
        backButton.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = pokemon.name.localizedCapitalized
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "poppins", size: 24)
        stackView.addArrangedSubview(nameLabel)
        
        let idLabel = UILabel()
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.textColor = .white
        idLabel.font = UIFont(name: "poppins", size: 12)
        idLabel.setContentHuggingPriority(.required, for: .horizontal)
        stackView.addArrangedSubview(idLabel)
        idLabel.text = pokemon.id.formatId()
    }
    
    private func subscribeObservers() {
        viewModel.state.sinkMain { [weak self] state in
            self?.handleState(state: state)
        }.store(in: &cancellables)
        viewModel.loadDescription(id: String(pokemon.id))
    }
    
    private func makeThreeColumnRow() -> UIStackView {
        let parentStackView = UIStackView()
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .horizontal
        parentStackView.alignment = .fill
        parentStackView.distribution = .fill

        parentStackView.addArrangedSubview(
            makeThreeColumnRowCell(
                label: "Weight",
                value: "\(pokemon.weightInKilos) kg",
                icon: UIImage(named: "weight")
            )
        )
        
        parentStackView.addArrangedSubview(makeDivider())
        parentStackView.addArrangedSubview(
            makeThreeColumnRowCell(
                label: "Height",
                value: "\(pokemon.heightInMeters) m",
                icon: UIImage(named: "height")
            )
        )
        
        return parentStackView
    }
    
    private func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#666666", alpha: CGFloat(0.2))
        view.widthAnchor.constraint(equalToConstant: CGFloat(1)).isActive = true
        view.heightAnchor.constraint(equalToConstant: CGFloat(60)).isActive = true
        view.setContentHuggingPriority(.defaultLow, for: . vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }
    
    private func makeThreeColumnRowCell(
        label: String,
        value: String,
        icon: UIImage? = nil
    ) -> UIView {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        let labelView = UILabel()
        labelView.text = label
        labelView.font = UIFont(name: "poppins", size: CGFloat(10))
        labelView.textColor = UIColor(hex: "#666666")
        labelView.textAlignment = .center
        labelView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(labelView)
        labelView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        cell.widthAnchor.constraint(equalToConstant: CGFloat(110)).isActive = true
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont(name: "poppins", size: CGFloat(14))
        valueLabel.text = value
        valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        if icon == nil {
            cell.addSubview(valueLabel)
            valueLabel.bottomAnchor.constraint(equalTo: labelView.topAnchor, constant: -12).isActive = true
            valueLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 12).isActive = true
            valueLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        } else {
            let iconTextRow = UIStackView()
            iconTextRow.axis = .horizontal
            iconTextRow.translatesAutoresizingMaskIntoConstraints = false
            iconTextRow.distribution = .fill
            iconTextRow.alignment = .fill
            iconTextRow.spacing = 8
            
            let iconImageView = UIImageView()
            iconImageView.image = icon
            iconTextRow.addArrangedSubview(iconImageView)
            iconTextRow.addArrangedSubview(valueLabel)
            
            cell.addSubview(iconTextRow)
            
            iconTextRow.bottomAnchor.constraint(equalTo: labelView.topAnchor, constant: -12).isActive = true
            iconTextRow.topAnchor.constraint(equalTo: cell.topAnchor, constant: 12).isActive = true
            iconTextRow.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        }
        
        return cell
    }
    
    @objc
    private func onTapBack() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
    private func handleState(state: PokemonDetailState) {
        switch state {
        case .finishedLoading(let description):
            loadingSpinner.isHidden = true
            loadingSpinner.stopAnimating()
            populateBottomStackView(description: description)
        case .loading:
            loadingSpinner.isHidden = false
            loadingSpinner.startAnimating()
        }
    }
}
