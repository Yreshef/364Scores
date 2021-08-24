//
//  TeamSummaryCard.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import UIKit
import SwiftSVG

class TeamSummaryCard: UIView {
    
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
        stackView.addArrangedSubview(label)
        
        return stackView
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
    
    func setup(teamName: String) {
        label.text = teamName
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


class SVGImageView: UIView {
    private var svgView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let view = svgView {
                addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.topAnchor.constraint(equalTo: topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                view.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
                view.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor).isActive = true
                view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(url: String) {
        guard let svgURL = URL(string: url) else { return }
        let logo = UIView(SVGURL: svgURL) { [weak self] (svgLayer) in
            guard let self = self else { return }
            svgLayer.resizeToFit(self.bounds)
        }
        self.svgView = logo
    }
}
