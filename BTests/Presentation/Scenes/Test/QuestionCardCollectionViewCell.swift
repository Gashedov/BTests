//
//  CardCollectionViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 2.05.21.
//

import UIKit

class QuestionCardCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let cardView = UIView()
    private let questionLabel = UILabel()
    private let answersStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(cardView)
        cardView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        cardView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }

        cardView.addSubview(answersStackView)
        answersStackView.snp.makeConstraints {
            $0.top.bottom.greaterThanOrEqualTo(snp.centerY).inset(20).priority(.high)
            $0.top.greaterThanOrEqualTo(questionLabel.snp.bottom).offset(20).priority(.low)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(40)
        }

        cardView.backgroundColor = .white
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.cornerRadius = 20

        questionLabel.textAlignment = .center
        questionLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        questionLabel.text = "Qestion text"
        questionLabel.numberOfLines = 0

        answersStackView.layer.cornerRadius = 10
        answersStackView.backgroundColor = .lightGray
        answersStackView.axis = .vertical
        answersStackView.distribution = .fillEqually
        answersStackView.alignment = .leading
        answersStackView.spacing = 16.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        answersStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func setupValues(question: String, answers: [String]) {
        questionLabel.text = question
        answers.forEach {
            let answerButton = UIButton()

            answerButton.setTitle($0, for: .normal)

            answersStackView.addArrangedSubview(answerButton)
        }
    }
}
