//
//  TestView2.swift
//  BTests
//
//  Created by Artem Gorshkov on 2.05.21.
//

import UIKit
import UPCarouselFlowLayout
import RxSwift
import RxCocoa

class TestView: UIViewController {
    // MARK: - Properties
    private let progressBarContainerView = UIView()
    private let progressLine = UIProgressView()
    private let progressLineInficator = UIView()
    private let progressCounterLabel = UILabel()

    private let cardCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UPCarouselFlowLayout()
    )

    private let disposeBag = DisposeBag()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(progressBarContainerView)
        progressBarContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        progressBarContainerView.addSubview(progressCounterLabel)
        progressCounterLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(60)
        }

        progressBarContainerView.addSubview(progressLine)
        progressLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(progressCounterLabel.snp.bottom).offset(16)
            $0.height.equalTo(10)
        }

        progressBarContainerView.addSubview(progressLineInficator)
        progressLineInficator.snp.makeConstraints {
            $0.centerY.leading.equalTo(progressLine)
            $0.width.equalTo(4)
            $0.height.equalTo(16)
        }

        view.addSubview(cardCollectionView)
        cardCollectionView.snp.makeConstraints {
            $0.top.equalTo(progressBarContainerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(60)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .lightGray

        progressBarContainerView.backgroundColor = .darkGray

        progressLine.backgroundColor = .cyan
        progressLineInficator.backgroundColor = .red

        progressCounterLabel.text = "0/3"

        cardCollectionView.backgroundColor = .clear
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.showsHorizontalScrollIndicator = false
        cardCollectionView.register(CardCollectionViewCell.self)
        cardCollectionView.register(LastCardCollectionViewCell.self)

        let layout = cardCollectionView.collectionViewLayout as? UPCarouselFlowLayout
        layout?.sideItemScale = 1
        layout?.sideItemAlpha = 1
        layout?.scrollDirection = .horizontal
    }

    @objc private func completeTest() {
        navigationController?.pushViewController(TestResultView(), animated: true)
    }
}

extension TestView: UICollectionViewDelegate {

}

extension TestView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == 3 {
            let cell: LastCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.resultButton.addTarget(self, action: #selector(completeTest), for: .touchUpInside)
            return cell
        }
        let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupValues(question: "<Question text>", answers: ["<answer one>", "<answer two>", "<answer tree>"])
        return cell
    }
}

extension TestView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width - 80,
            height: collectionView.frame.height - 80
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension TestView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        var percentageOfFullWidth = offset.x / (scrollView.contentSize.width - scrollView.frame.width)

        progressLine.setProgress(Float(percentageOfFullWidth), animated: true)

        percentageOfFullWidth = percentageOfFullWidth > 1 ? 1 : percentageOfFullWidth
        percentageOfFullWidth = percentageOfFullWidth < 0 ? 0 : percentageOfFullWidth
        UIView.animate(withDuration: 0.01) {
            self.progressLineInficator.center.x = self.progressLine.frame.width*percentageOfFullWidth
        }
    }
}
