//
//  UserVerificationView.swift
//  BTests
//
//  Created by Artem Gorshkov on 10.05.21.
//

import UIKit

class AuthorizationView: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let containerView = UIView()
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

        containerView.addSubview(credentionalsContainer)
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
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = R.color.primaryColor()

        credentionalsTitle.text = R.string.localizable.contactDetails()

        credentionalsContainer.backgroundColor = R.color.elementBackground()
        credentionalsContainer.layer.cornerRadius = 10

        nameTextField.placeholder = R.string.localizable.name()
        nameTextField.titleActiveTextColor = R.color.primaryColor()
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done

        surnameTextField.placeholder = R.string.localizable.surname()
        surnameTextField.titleActiveTextColor = R.color.primaryColor()
        surnameTextField.delegate = self
        surnameTextField.returnKeyType = .done

        cityTextField.placeholder = R.string.localizable.city()
        cityTextField.titleActiveTextColor = R.color.primaryColor()
        cityTextField.delegate = self
        cityTextField.returnKeyType = .done

        phoneNumberTextField.placeholder = R.string.localizable.phoneNumber()
        phoneNumberTextField.titleActiveTextColor = R.color.primaryColor()
        phoneNumberTextField.delegate = self
        phoneNumberTextField.returnKeyType = .done

        confirmButton.setTitle(R.string.localizable.confirm(), for: .normal)
        confirmButton.backgroundColor = R.color.elementTint()
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        confirmButton.layer.cornerRadius = 20

        skipButton.setTitle(R.string.localizable.skip(), for: .normal)
        skipButton.setTitleColor(R.color.primaryColor(), for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
    }

    // MARK: - Private methods
    @objc private func skip() {
        presentMainScreen()
    }

    @objc private func confirm() {
        // send contact details
        presentMainScreen()
    }

    private func presentMainScreen() {
        let navigation = UINavigationController(rootViewController: MainScreenView())
        navigation.isModalInPresentation = true
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

extension AuthorizationView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
