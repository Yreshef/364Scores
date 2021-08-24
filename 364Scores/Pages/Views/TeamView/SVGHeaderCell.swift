//
//  SVGHeaderCell.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import UIKit

class SVGHeaderCell: UITableViewCell {
    
    static let cellID = "SVGHeaderCell"
    
    // MARK: - Properties | Components
    
    private let view = SVGImageView()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    func setup(svgURL: String) {
        view.load(url: svgURL)
    }
    
    private func setConstraints() {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
