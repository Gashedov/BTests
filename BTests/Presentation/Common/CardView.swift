//
//  CardView.swift
//  BTests
//
//  Created by Artem Gorshkov on 13.04.21.
//

import UIKit

class CardView: UIView {
    private let titleLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let logoImageView = UIImageView()

    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

        addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }

        addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(60)
        }

        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }

        backgroundColor = .white

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "Faculty name"

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = "Full name of faculty"

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam efficitur sapien nulla, vitae sodales sapien ultrices et. Morbi velit sem, bibendum vitae cursus ac, iaculis id massa. Maecenas iaculis enim nec arcu commodo porta. Etiam accumsan maximus augue vitae tempus. Vestibulum ac est purus. Etiam ut erat ullamcorper, bibendum metus in, volutpat quam. Donec varius at tellus ac pretium. Cras quam purus, tristique nec ipsum a, hendrerit iaculis ante. Integer pulvinar sodales neque, nec consequat nisi pulvinar non. Quisque ullamcorper nunc vel dolor interdum, a laoreet justo tincidunt. Duis at tempus mi. Proin id consectetur dolor. Maecenas nisl felis, gravida vitae quam vitae, placerat pharetra enim. Suspendisse ultricies imperdiet ante molestie accumsan. Donec mollis eleifend tortor, ac lobortis quam eleifend et."
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10

        layer.cornerRadius = 20
    }

    func setupValues(title: String, fullName: String, description: String) {
        titleLabel.text = title
        fullNameLabel.text = fullName
        descriptionLabel.text = description
    }
}
