//
//  UserVerificationView.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import UIKit

class AuthorizationView: UIViewController {
    //MARK: - Properties
    private let credentionalsContainer = UIView()
    private let credentionalsTitle = UILabel()
    private let nameTextField = FloatLabelTextField()
    private let surnameTextField = FloatLabelTextField()
    private let cityTextField = FloatLabelTextField()
    private let phoneNumberTextField = FloatLabelTextField()
    private let confirmButton = UIButton()
    private let skipButton = UIButton()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(credentionalsContainer)
        credentionalsContainer.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }

        credentionalsContainer.addSubview(credentionalsTitle)
        credentionalsTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }

        credentionalsContainer.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(credentionalsTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }

        credentionalsContainer.addSubview(surnameTextField)
        surnameTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }

        credentionalsContainer.addSubview(cityTextField)
        cityTextField.snp.makeConstraints {
            $0.top.equalTo(surnameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }

        credentionalsContainer.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }

        credentionalsContainer.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(50)
        }

        credentionalsContainer.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(60)
            $0.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = R.color.primaryColor()

        credentionalsTitle.text = "Credentinals"

        credentionalsContainer.backgroundColor = R.color.elementBackground()
        credentionalsContainer.layer.cornerRadius = 10

        nameTextField.placeholder = R.string.localizable.name()
        nameTextField.titleActiveTextColor = R.color.primaryColor()

        surnameTextField.placeholder = R.string.localizable.surname()
        surnameTextField.titleActiveTextColor = R.color.primaryColor()

        cityTextField.placeholder = R.string.localizable.city()
        cityTextField.titleActiveTextColor = R.color.primaryColor()

        phoneNumberTextField.placeholder = R.string.localizable.phoneNumber()
        phoneNumberTextField.titleActiveTextColor = R.color.primaryColor()

        confirmButton.setTitle(R.string.localizable.confirm(), for: .normal)
        confirmButton.backgroundColor = R.color.elementTint()
        confirmButton.layer.cornerRadius = 20

        skipButton.setTitle(R.string.localizable.skip(), for: .normal)
        skipButton.setTitleColor(R.color.primaryColor(), for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
    }

    // MARK: - Private methods
    @objc private func skip() {
        let navigation = UINavigationController(rootViewController:  MainScreenView())
        navigation.isModalInPresentation = true
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
