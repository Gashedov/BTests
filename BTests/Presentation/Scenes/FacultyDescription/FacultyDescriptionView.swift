//
//  FacultyDescriptionView.swift
//  BTests
//
//  Created by Artem Gorshkov on 17.05.21.
//

import UIKit

class FacultyDescriptionView: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let trayView = UIView()
    private let expandView = UIView()
    private let expandImageView = UIImageView()
    private let specialtyTableView = UITableView()

    private let trayViewOffset: CGFloat = 70

    private var trayViewClosed = true

    var viewModel: FacultyDescriptionViewModel?

    //MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(trayViewOffset)
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

        view.addSubview(trayView)
        trayView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(scrollView.snp.bottom)
            $0.height.equalTo(500)
        }

        trayView.addSubview(expandView)
        expandView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

        trayView.addSubview(specialtyTableView)
        specialtyTableView.snp.makeConstraints {
            $0.top.equalTo(expandView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        expandView.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureRecognizers()
        viewModel?.delegate = self
        viewModel?.fetchSpecialties()
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

    private func setupUI() {
        let faculty = viewModel?.fetchFuculty()
        view.backgroundColor = R.color.elementBackground()

        specialtyTableView.register(SpecialtyTableViewCell.self)

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = faculty?.name
        titleLabel.textColor = .darkGray

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = faculty?.fullName
        fullNameLabel.textColor = .darkGray

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = faculty?.description

        trayView.backgroundColor = R.color.elementBackground()
        expandView.backgroundColor = R.color.primaryColor()
        expandImageView.image = R.image.arrowUp()
        expandImageView.tintColor = .white
        expandImageView.contentMode = .scaleAspectFit

        specialtyTableView.delegate = self
        specialtyTableView.dataSource = self
        specialtyTableView.backgroundColor = R.color.elementBackground()
    }

    private func configureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragView))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTaped))
        tapGestureRecognizer.require(toFail: panGestureRecognizer)
        trayView.addGestureRecognizer(panGestureRecognizer)
        expandView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func viewTaped() {
        if trayViewClosed {
            openTrayView()
        } else {
            closeTrayView()
        }
    }

    @objc private func dragView(gesture: UIPanGestureRecognizer) {
        guard let target = gesture.view else { return }
        let alignmentYValue = (view.bounds.height - target.frame.height)/2
        let transition = gesture.translation(in: view)

        switch gesture.state {
        case .changed:
            // stop moving if view were draged higher than needed
            if target.frame.minY < view.bounds.height - target.frame.height + trayViewOffset/2,
               transition.y < 0 {
                gesture.setTranslation(.zero, in: view)
                return
            }

            target.center = CGPoint(x: target.center.x, y: target.center.y + transition.y)
            gesture.setTranslation(.zero, in: view)
        case .ended:
                // close if view were moved down more than aligment value
                // or view were moved out of bottom screen bound
                let wasMovedOutOfBottomBound = target.frame.minY + trayViewOffset > view.frame.maxY
                let shouldClose = target.frame.minY > view.bounds.height - alignmentYValue

                if wasMovedOutOfBottomBound || shouldClose {
                    closeTrayView()
                }

                // open if view were moved higher than aligment line
                if target.frame.minY < view.bounds.height - alignmentYValue {
                    openTrayView()
                }
        default:
            break
        }
    }

    private func closeTrayView() {
        let bottomSaveAreaInset = view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.25) {
            self.trayView.center.y = self.view.frame.maxY +
                (self.trayView.frame.height - self.trayViewOffset)/2 - bottomSaveAreaInset
            self.expandImageView.image = R.image.arrowUp()
        }
        trayViewClosed = true
    }

    private func openTrayView() {
        UIView.animate(withDuration: 0.25) {
            self.trayView.center.y = self.view.center.y +
                (self.view.frame.height - self.trayView.frame.height)/2
            self.expandImageView.image = R.image.arrowDown()
        }
        trayViewClosed = false
    }
}

extension FacultyDescriptionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openSpecialtyView()
    }
}

extension FacultyDescriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.specialties.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SpecialtyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let specialty = viewModel?.specialties[indexPath.row] else { return UITableViewCell() }
        cell.setup(shortName: specialty.name, fullName: specialty.secondSubjectName)
        return cell
    }
}

extension FacultyDescriptionView: FacultyDescriptionViewModelDelegate {
    func specialtiesFetched() {
        specialtyTableView.reloadData()
    }
}
