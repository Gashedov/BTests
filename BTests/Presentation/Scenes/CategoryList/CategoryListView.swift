//
//  CategoryListView.swift
//  BTests
//
//  Created by Artem Gorshkov on 31.03.21.
//

import UIKit

class CategoryListView: UIViewController {

    // MARK: - Properties
    private let buttonsContainerView = UIView()

    private let searchButton = UIButton()
    private let searchLabel = UILabel()

    private let testButton = UIButton()
    private let testLabel = UILabel()

    private let infoButton = UIButton()
    private let infoLabel = UILabel()

    private let creatorsButton = UIButton()
    private let creatorsLabel = UILabel()

    private let trayView = UIView()
    private let cardStack = CardStackView()

    private let trayViewOffset: CGFloat = 400

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(buttonsContainerView)
        buttonsContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(220)
        }

        buttonsContainerView.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(80)
        }

        buttonsContainerView.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom)
            $0.centerX.equalTo(testButton)
        }

        buttonsContainerView.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(80)
        }

        buttonsContainerView.addSubview(searchLabel)
        searchLabel.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom)
            $0.centerX.equalTo(searchButton)
        }

        buttonsContainerView.addSubview(infoButton)
        infoButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.size.equalTo(80)
        }

        buttonsContainerView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(infoButton.snp.bottom)
            $0.centerX.equalTo(infoButton)
        }


        buttonsContainerView.addSubview(creatorsButton)
        creatorsButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.size.equalTo(80)
        }

        buttonsContainerView.addSubview(creatorsLabel)
        creatorsLabel.snp.makeConstraints {
            $0.top.equalTo(creatorsButton.snp.bottom)
            $0.centerX.equalTo(creatorsButton)
        }

        view.addSubview(trayView)
        trayView.snp.makeConstraints {
            $0.trailing.leading.height.equalToSuperview()
            $0.top.equalTo(view.snp.bottom).inset(trayViewOffset)
        }

        trayView.addSubview(cardStack)
        cardStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        trayView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .lightGray
        trayView.backgroundColor = .clear

        testButton.setImage(R.image.cards(), for: .normal)
        testButton.tintColor = .black
        testButton.contentVerticalAlignment = .fill
        testButton.contentHorizontalAlignment = .fill
        testButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        testButton.addTarget(self, action: #selector(testButtonAction), for: .touchUpInside)

        testLabel.text = R.string.localizable.test()

        searchButton.setImage(R.image.search(), for: .normal)
        searchButton.tintColor = .black
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill

        searchLabel.text = R.string.localizable.search()

        creatorsButton.setImage(R.image.creators(), for: .normal)
        creatorsButton.tintColor = .black
        creatorsButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        creatorsButton.contentVerticalAlignment = .fill
        creatorsButton.contentHorizontalAlignment = .fill

        creatorsLabel.text = R.string.localizable.creators()

        infoButton.setImage(R.image.about(), for: .normal)
        infoButton.tintColor = .black
        infoButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        infoButton.contentVerticalAlignment = .fill
        infoButton.contentHorizontalAlignment = .fill

        infoLabel.text = R.string.localizable.about()
    }

    @objc private func testButtonAction() {
        navigationController?.pushViewController(TestDescriptionView(), animated: true)
    }

    @objc private func dragView(gesture: UIPanGestureRecognizer) {
        guard let target = gesture.view else { return }
        let velocity = gesture.velocity(in: self.view).y/50
        let alignmentYValue = (view.bounds.maxY-trayViewOffset)/2

        switch gesture.state {
        case .changed:
            UIView.animate(withDuration: 0.25) {
                guard target.frame.minY > self.view.bounds.minY-10 else {
                    target.center.y = self.view.center.y
                    return
                }
                target.center = CGPoint(x: target.center.x, y: target.center.y + velocity)
            }
        case .ended:
            UIView.animate(withDuration: 0.25) {
                if target.frame.minY < self.view.bounds.minY ||
                    target.frame.minY+velocity < alignmentYValue {
                    target.center.y = self.view.center.y
                }
                if target.frame.minY+velocity > alignmentYValue {
                    target.center.y = self.view.center.y+self.trayViewOffset
                }
            }
        default:
            break
        }
    }
}
