//
//  TestResultView.swift
//  BTests
//
//  Created by Artem Gorshkov on 7.05.21.
//

import UIKit

class TestResultView: UIViewController {
    // MARK: - Properties
    private let backgroundView = GradientedView()
    private let resultTitle = UILabel()
    private let resultLabel = UILabel()
    private let infoButton = UIButton()
    private let nextButton = UIButton()
    private let menuButton = UIButton()

    var viewModel: TestResultViewModel?

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(resultTitle)
        resultTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(160)
            $0.leading.trailing.equalToSuperview()
        }

        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(180)
        }

        view.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(180)
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.applyGradient(
            startPoint: CGPoint(x: 0.5, y: -0.7),
            endPoint: CGPoint(x: 0.5, y: 0.5),
            colorArray: [.white, R.color.primaryColor()]
        )
    }

    // MARK: - Private methods
    private func setupUI() {

        view.backgroundColor = R.color.elementBackground()

        resultTitle.font = .systemFont(ofSize: 24)
        resultTitle.text = "По результатам теста вам больше всего подходит:"
        resultTitle.textAlignment = .center
        resultTitle.numberOfLines = 2

        resultLabel.font = .boldSystemFont(ofSize: 24)
        resultLabel.text = "ФИТР"
        resultLabel.textAlignment = .center

        infoButton.setImage(R.image.about(), for: .normal)
        infoButton.layer.cornerRadius = 30
        infoButton.contentVerticalAlignment = .fill
        infoButton.contentHorizontalAlignment = .fill
        infoButton.tintColor = R.color.elementTint()

        nextButton.setTitle("Следующий тест", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.addTarget(self, action: #selector(openNext), for: .touchUpInside)
        nextButton.backgroundColor = R.color.elementTint()
        nextButton.layer.cornerRadius = 16

        menuButton.setTitle("Назад в меню", for: .normal)
        menuButton.setTitleColor(.black, for: .normal)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.backgroundColor = R.color.elementTint()
        menuButton.layer.cornerRadius = 16

    }

    @objc private func openNext() {
        viewModel?.openNextTest()
    }

    @objc private func openMenu() {
        viewModel?.goToMainScreen()
    }
}
