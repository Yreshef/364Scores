//
//  SquadMemberView.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import UIKit

class SquadMemberView: UIView {
    //TODO: Style and naming
    // MARK: - Properties | Components
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    // MARK: - Variables
    
    private let playerIcons = [
        UIImage(named: "footballPlayerIcon1"),
        UIImage(named: "footballPlayerIcon2"),
        UIImage(named: "footballPlayerIcon3")
    ]
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setup(playerName: String) {
        label.text = playerName
        imageView.image = playerIcons[Int.random(in: 0...2)]
    }
    
    private func setConstraints() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
}

