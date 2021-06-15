//
//  TestDescriptionView.swift
//  BTests
//
//  Created by Artem Gorshkov on 29.04.21.
//

import UIKit

class TestDescriptionView: UIViewController {
    // MARK: - Properties
    private let backgroundView = GradientedView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let goButton = UIButton()

    var viewModel: TestDescriptionViewModel?

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
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
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.backIndicatorImage = R.image.backButton()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = R.image.backButton()
        navigationController?.navigationBar.tintColor = .black

        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.backItem?.title = ""
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
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
        backgroundView.backgroundColor = .lightGray

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "ТЕСТ: какой факультет мне подходит "
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center

        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.text = "Этот тест содержит вопросы, ответив на который система сможет определить предрасположенность к определенному типу деятельности и, более того, поможет определиться с факультетом БНТУ"
        descriptionLabel.numberOfLines = 0

        goButton.setTitle("НАЧАТЬ", for: .normal)
        goButton.addTarget(self, action: #selector(openTest), for: .touchUpInside)
        goButton.layer.cornerRadius = 20
        goButton.backgroundColor = R.color.elementTint()
        goButton.setTitleColor(.lightGray, for: .normal)

        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(openTest))
        )
    }

    @objc private func openTest() {
        viewModel?.openTest()
    }
}
