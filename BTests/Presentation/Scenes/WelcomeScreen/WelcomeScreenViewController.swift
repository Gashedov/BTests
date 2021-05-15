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
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(100)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        backgroundImageView.backgroundColor = .lightGray

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "Welcome to B`Test"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center

        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openNext))
        )
    }

    @objc private func openNext() {
        let authorizationView = AuthorizationView()
        authorizationView.isModalInPresentation = true
        authorizationView.modalPresentationStyle = .fullScreen
        present(authorizationView, animated: true)
    }
}

