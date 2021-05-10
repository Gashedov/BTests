//
//  TestDescriptionView.swift
//  BTests
//
//  Created by Artem Gorshkov on 29.04.21.
//

import UIKit

class TestDescriptionView: UIViewController {
    // MARK: - Properties
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let goButton = UIButton()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(100)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(60)
        }

        view.addSubview(goButton)
        goButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(60)
            $0.width.equalTo(150)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
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
        backgroundImageView.backgroundColor = .lightGray

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "Specialty test"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center

        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.text = "Test descriprion"
        descriptionLabel.numberOfLines = 0

        goButton.setTitle("GO", for: .normal)
        goButton.addTarget(self, action: #selector(openNext), for: .touchUpInside)

        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openNext))
        )
    }

    @objc private func openNext() {
        navigationController?.pushViewController(TestView(), animated: true)
    }
}
