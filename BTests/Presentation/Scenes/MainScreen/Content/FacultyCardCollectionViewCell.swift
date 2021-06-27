//
//  FacultyCardCollectionViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.05.21.
//

import UIKit

class FacultyCardTableViewCell: UITableViewCell, ReuseIdentifiable {
    private let cardView = UIView()
    private let cardViewHeader = UIView()
    private let facultyNameLabel = UILabel()
    private let fullFacultyNameLabel = UILabel()
    private let facultyDescriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(50)
        }

        cardView.addSubview(cardViewHeader)
        cardViewHeader.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.25)
        }

        cardViewHeader.addSubview(facultyNameLabel)
        facultyNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        cardView.addSubview(fullFacultyNameLabel)
        fullFacultyNameLabel.snp.makeConstraints {
            $0.top.equalTo(cardViewHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }

        cardView.addSubview(facultyDescriptionLabel)
        facultyDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fullFacultyNameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = R.color.elementBackground()
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true

        cardViewHeader.backgroundColor = R.color.secondaryColor()
        cardViewHeader.clipsToBounds = true

        facultyNameLabel.textAlignment = .center
        facultyNameLabel.font = .systemFont(ofSize: 22, weight: .semibold)

        fullFacultyNameLabel.textAlignment = .center
        fullFacultyNameLabel.font = .systemFont(ofSize: 12, weight: .light)
        fullFacultyNameLabel.numberOfLines = 2

        facultyDescriptionLabel.font = .systemFont(ofSize: 14)
        facultyDescriptionLabel.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupValues(name: String, fullName: String, description: String) {
        facultyNameLabel.text = name
        fullFacultyNameLabel.text = fullName
        facultyDescriptionLabel.text = description
    }
}
