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
    let backgroundImageView = UIImageView()
    let titleLabel = UILabel()
    let confirmButton = UIButton()

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

        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(60)
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

        confirmButton.setTitle("GO", for: .normal)
        confirmButton.backgroundColor = .cyan
        confirmButton.layer.cornerRadius = 30
    
    }
}

