//
//  TestCardView.swift
//  BTests
//
//  Created by Artem Gorshkov on 29.04.21.
//

import UIKit

class TestCardView: UIView {
    private let questionLabel = UILabel()
    private let answersStackView = UIStackView()

    init() {
        super.init(frame: .zero)
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }

        addSubview(answersStackView)
        answersStackView.snp.makeConstraints {
            $0.top.bottom.greaterThanOrEqualTo(snp.centerY).inset(20).priority(.high)
            $0.top.greaterThanOrEqualTo(questionLabel.snp.bottom).offset(20).priority(.low)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(40)
        }

        backgroundColor = .white

        questionLabel.textAlignment = .center
        questionLabel.font = .systemFont(ofSize: 22, weight: .semibold)
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

    override func layoutSubviews() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.cornerRadius = 20
    }

    func setupValues(question: String, answers: [TestAnswer]) {
        questionLabel.text = question
        answers.forEach {
            let answerView = UIView()
            let answerLabel = UILabel()

            answerView.addSubview(answerLabel)
            answerLabel.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(12)
            }

            answerView.backgroundColor = .darkGray
            answerView.layer.cornerRadius = 10

            answerLabel.textAlignment = .left
            answerLabel.font = .systemFont(ofSize: 12)
            answerLabel.text = $0.title

            answersStackView.addArrangedSubview(answerLabel)
        }
    }

    func clear() {
        print(answersStackView.arrangedSubviews)
        answersStackView.arrangedSubviews.forEach {
            answersStackView.removeArrangedSubview($0)
        }
        print(answersStackView.arrangedSubviews)
    }
}
