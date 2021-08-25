//
//  UpcomingFixureView.swift
//  364Scores
//
//  Created by Yohai Reshef on 25/08/2021.
//

import UIKit

class UpcomingFixureView: UIView {
    //TODO: Style and naming
    // MARK: - Properties | Components
    
    private let matchdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 10)

        return label
    }()
    
    private let competitionLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(competitionLabel)
        
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        return stackView
    }()

    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(matchdayLabel)

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4

        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(middleStackView)
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
 
    
    private lazy var cardView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .cyan.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        
//        view.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: view.topAnchor,
//                                             constant: 0).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
//                                                 constant: 8).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
//                                          constant: 0).isActive = true
        
//        view.addSubview(middleStackView)
//        middleStackView.translatesAutoresizingMaskIntoConstraints = false
//        middleStackView.topAnchor.constraint(
//            equalTo: headerStackView.bottomAnchor, constant: 10).isActive = true
//        middleStackView.leadingAnchor.constraint(
//            equalTo: imageView.trailingAnchor, constant: 20).isActive = true
//        middleStackView.trailingAnchor.constraint(
//            equalTo: view.trailingAnchor, constant: -8).isActive = true
//        middleStackView.bottomAnchor.constraint(
//            equalTo: view.bottomAnchor, constant: 0).isActive = true
//        middleStackView.centerXAnchor.constraint(
//            equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(
                  equalTo: view.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(
                  equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(
                  equalTo: view.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(
                  equalTo: view.bottomAnchor, constant: 0).isActive = true
//        stackView.centerXAnchor.constraint(
//                  equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
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
    
    func setup(homeTeam: String, awayTeam: String,
               date: String, competition: String) {
        matchdayLabel.text = "\(homeTeam) - \(awayTeam)"
        dateLabel.text = date
        competitionLabel.text = competition
        imageView.image = R.image.fieldIcon()
    }
    
    private func setConstraints() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: topAnchor,
                                      constant: 8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: 16).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                           constant: -16).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                         constant: -8).isActive = true
    }
    
}
