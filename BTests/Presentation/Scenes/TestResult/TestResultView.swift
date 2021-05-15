//
//  TestResultView.swift
//  BTests
//
//  Created by Artem Gorshkov on 7.05.21.
//

import UIKit

class TestResultView: UIViewController {
    // MARK: - Properties
    private let resultTitle = UILabel()
    private let resultLabel = UILabel()
    private let logoImageView = UIImageView()
    private let infoButton = UIButton()
    private let nextButton = UIButton()
    private let menuButton = UIButton()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(resultTitle)
        resultTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(20)
        }

        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(40)
        }

        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(resultLabel.snp.bottom).offset(80)
            $0.size.equalTo(180)
        }

        view.addSubview(infoButton)
        infoButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(logoImageView)
            $0.size.equalTo(60)
        }

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        view.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
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

        resultTitle.font = .boldSystemFont(ofSize: 24)
        resultTitle.text = "Result:"
        resultTitle.textAlignment = .center

        resultLabel.font = .systemFont(ofSize: 18)
        resultLabel.text = "<Test result>"

        logoImageView.backgroundColor = .darkGray
        logoImageView.layer.cornerRadius = 90

        infoButton.setImage(R.image.about(), for: .normal)
        infoButton.layer.cornerRadius = 30
        infoButton.contentVerticalAlignment = .fill
        infoButton.contentHorizontalAlignment = .fill
        infoButton.tintColor = .white

        nextButton.setTitle("Next test", for: .normal)
        nextButton.addTarget(self, action: #selector(openNext), for: .touchUpInside)
        nextButton.backgroundColor = .lightGray

        menuButton.setTitle("Go to menu", for: .normal)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.backgroundColor = .lightGray

    }

    @objc private func openNext() {
        navigationController?.pushViewController(TestDescriptionView(), animated: true)
    }

    @objc private func openMenu() {
        navigationController?.popToRootViewController(animated: true)
    }
}
