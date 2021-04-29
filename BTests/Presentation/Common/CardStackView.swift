//
//  CardStackView.swift
//  BTests
//
//  Created by Artem Gorshkov on 13.04.21.

import UIKit
import SnapKit

class CardStackView: UIView {
    private let frontCard = CardView()
    private let backCard = CardView()

    private let frontCardConstraintsMake: (ConstraintMaker) -> Void = {
        $0.center.equalToSuperview()
        $0.width.height.equalToSuperview()
    }

    private let backCardConstraintsMake: (ConstraintMaker) -> Void = {
        $0.centerX.equalToSuperview()
        $0.centerY.equalToSuperview().offset(-10)
        $0.height.width.equalToSuperview()
    }

    private var presentedCard: UIView

    init() {
        presentedCard = frontCard
        super.init(frame: .zero)

        backgroundColor = .clear

        addSubview(backCard)
        backCard.snp.makeConstraints(backCardConstraintsMake)

        addSubview(frontCard)
        frontCard.snp.makeConstraints(frontCardConstraintsMake)

        frontCard.setupValues(title: "First", fullName: "", description: "")
        backCard.setupValues(title: "Second", fullName: "", description: "")

        addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(moveToNextCard))
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func moveToNextCard() {
        UIView.animate(withDuration: 0.25) {
            guard let frontCard = self.subviews.first(where: { $0 == self.presentedCard }) else { return }
            guard let backCard = self.subviews.first(where: { $0 != self.presentedCard }) else { return }
            frontCard.removeFromSuperview()

            backCard.snp.updateConstraints(self.frontCardConstraintsMake)

            self.insertSubview(frontCard, at: 0)
            frontCard.snp.makeConstraints(self.backCardConstraintsMake)

            self.presentedCard = backCard
        }
    }
}
