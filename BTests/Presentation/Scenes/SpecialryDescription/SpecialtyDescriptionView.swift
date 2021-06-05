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
    
    private func setupUI() {
        view.backgroundColor = R.color.elementBackground()

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "ПОИТ"
        titleLabel.textColor = .darkGray

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = "Программное обеспечение информационных технологий"
        fullNameLabel.textColor = .darkGray

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "Направление специальности ориентировано на подготовку программистов, владеющих современными информационными технологиями обработки и представления информации в технике, производстве, социальной сфере. Обучение студентов ведется с учетом новых тенденций развития интегрированных сред, распределенной обработки данных, разработки приложений для мобильных устройств, хранения и доступа к данным на основе востребованных систем управления базами данных. Особое внимание уделяется изучению технологий разработки Internet и Web-приложений, проектированию информационного обеспечения, организации информационно-вычислительных процессов и систем, систем сбора, хранения и обработки текстовой и графической информации."
    }
}
