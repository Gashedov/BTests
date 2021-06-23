//
//  ViewController.swift
//  BTests
//
//  Created by Artem Gorshkov on 28.03.21.
//

import UIKit
import SnapKit
import Rswift

class WelcomeScreenViewController: UIViewController {

    // MARK: - Properties
    private let backgroundView = GradientedView()
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.size.equalTo(150)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        logoImageView.image = R.image.appImage()
        logoImageView.layer.cornerRadius = 20
        logoImageView.clipsToBounds = true

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = R.string.localizable.welcome()
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.elementTint()

        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openNext))
        )
    }

    @objc private func openNext() {
        let authorizationView = AuthorizationBuilderImpl().build()
        authorizationView.isModalInPresentation = true
        authorizationView.modalPresentationStyle = .fullScreen
        present(authorizationView, animated: true)
    }
}

