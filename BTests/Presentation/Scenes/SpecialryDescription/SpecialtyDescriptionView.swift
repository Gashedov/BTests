//
//  SpecialtyDescriptionView.swift
//  BTests
//
//  Created by Artem Gorshkov on 17.05.21.
//

import UIKit

class SpecialtyDescriptionView: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let descriptionLabel = UILabel()

    //MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

        containerView.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
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
        
        navigationController?.navigationBar.backItem?.title = ""
    }

    private func setupUI() {
        view.backgroundColor = R.color.elementBackground()

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "Faculty name"
        titleLabel.textColor = .darkGray

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = "Full name of faculty"
        fullNameLabel.textColor = .darkGray

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam efficitur sapien nulla, vitae sodales sapien ultrices et. Morbi velit sem, bibendum vitae cursus ac, iaculis id massa. Maecenas iaculis enim nec arcu commodo porta. Etiam accumsan maximus augue vitae tempus. Vestibulum ac est purus. Etiam ut erat ullamcorper, bibendum metus in, volutpat quam. Donec varius at tellus ac pretium. Cras quam purus, tristique nec ipsum a, hendrerit iaculis ante. Integer pulvinar sodales neque, nec consequat nisi pulvinar non. Quisque ullamcorper nunc vel dolor interdum, a laoreet justo tincidunt. Duis at tempus mi. Proin id consectetur dolor. Maecenas nisl felis, gravida vitae quam vitae, placerat pharetra enim. Suspendisse ultricies imperdiet ante molestie accumsan. Donec mollis eleifend tortor, ac lobortis quam eleifend et."
    }
}
