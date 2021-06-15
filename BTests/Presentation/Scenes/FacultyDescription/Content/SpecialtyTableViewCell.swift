//
//  SpecialtyTableViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 22.05.21.
//

import UIKit

class SpecialtyTableViewCell: UITableViewCell, ReuseIdentifiable {
    //MARK: - Properties
    private let shortNameLabel = UILabel()
    private let fullNameLabel = UILabel()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(shortNameLabel)
        shortNameLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(10)
        }

        contentView.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(shortNameLabel.snp.bottom).offset(10)
        }

        shortNameLabel.font = .systemFont(ofSize: 10, weight: .bold)
        fullNameLabel.font = .systemFont(ofSize: 14)
        fullNameLabel.numberOfLines = 2

        backgroundColor = R.color.elementBackground()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods
    func setup(shortName: String, fullName: String) {
        shortNameLabel.text = shortName
        fullNameLabel.text = fullName
    }
    
}
