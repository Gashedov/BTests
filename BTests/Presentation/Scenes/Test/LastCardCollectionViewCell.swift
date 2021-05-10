//
//  LastCardCollectionViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import UIKit

class LastCardCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let cardView = UIView()
    private let resultTitle = UILabel()
    let resultButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(cardView)
        cardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        cardView.addSubview(resultTitle)
        resultTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }

        cardView.addSubview(resultButton)
        resultButton.snp.makeConstraints {
            $0.top.equalTo(resultTitle.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }

        cardView.backgroundColor = .green
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.cornerRadius = 20

        resultTitle.textAlignment = .center
        resultTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        resultTitle.text = R.string.localizable.completeTest()

        resultButton.setTitle(R.string.localizable.tapToComplete(), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
