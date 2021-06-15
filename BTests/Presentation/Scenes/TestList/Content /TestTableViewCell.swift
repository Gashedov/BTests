//
//  TestTableViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.05.21.
//

import UIKit

class TestTableViewCell: UITableViewCell, ReuseIdentifiable {
    //MARK: - Properties
    private let titleLabel = UILabel()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }

        backgroundColor = R.color.elementTint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods
    func setup(title: String) {
        titleLabel.text = title
    }
}
