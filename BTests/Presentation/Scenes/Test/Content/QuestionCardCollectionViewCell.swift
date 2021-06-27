//
//  CardCollectionViewCell.swift
//  BTests
//
//  Created by Artem Gorshkov on 2.05.21.
//

import UIKit

protocol QuestionCardCollectionViewCellDelegate: AnyObject {
    func anwerSelected(withNumber: Int, andQuestionNumber: Int)
}

class QuestionCardCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    private let cardView = UIView()
    private let questionLabel = UILabel()
    private let answersStackView = UIStackView()

    weak var delegate: QuestionCardCollectionViewCellDelegate?

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

        cardView.backgroundColor = R.color.elementTint()
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.cornerRadius = 20

        questionLabel.textAlignment = .center
        questionLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        questionLabel.numberOfLines = 0

        answersStackView.layer.cornerRadius = 10
        answersStackView.backgroundColor = R.color.elementBackground()
        answersStackView.axis = .vertical
        answersStackView.distribution = .fillEqually
        answersStackView.alignment = .fill
        answersStackView.spacing = 16.0

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isUserInteractionEnabled = true

        answersStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func setupValues(question: String, answers: [TestAnswer]) {
        questionLabel.text = question

        for index in 0..<answers.count {
            let answerButton = MultiLineButton()

            answerButton.setTitle(answers[index].title, for: .normal)
            answerButton.setTitleColor(.black, for: .normal)
            answerButton.tag = index
            answerButton.layer.cornerRadius = 10

            answerButton.addTarget(self, action: #selector(answerButtonAction), for: .touchUpInside)

            if answers[index].isSelected {
                answerButton.backgroundColor = R.color.primaryColor()
                isUserInteractionEnabled = false
            }

            answersStackView.addArrangedSubview(answerButton)
        }
    }

    @objc func answerButtonAction(_ sender: UIControl) {
        sender.backgroundColor = R.color.primaryColor()
        isUserInteractionEnabled = false
        delegate?.anwerSelected(withNumber: sender.tag, andQuestionNumber: tag)
    }
}
