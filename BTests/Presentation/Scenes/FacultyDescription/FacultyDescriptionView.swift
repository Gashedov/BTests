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
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragView))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTaped))
        tapGestureRecognizer.require(toFail: panGestureRecognizer)
        trayView.addGestureRecognizer(panGestureRecognizer)
        expandView.addGestureRecognizer(tapGestureRecognizer)
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
        view.backgroundColor = R.color.elementBackground()

        specialtyTableView.register(SpecialtyTableViewCell.self)

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "ФИТР"
        titleLabel.textColor = .darkGray

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = "Факультет информационных технологий и робототехники"
        fullNameLabel.textColor = .darkGray

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "Факультет создан в 1983 г. как факультет роботов и робототехнических систем на базе трех старейших кафедр Белорусского политехнического института: высшей математики, технической физики, электропривода и автоматизации промышленных установок и технологических комплексов и молодой кафедры– автоматизации и комплексной механизации.Факультет начинался с двух специальностей: Автоматизация технологических процессов и производств и «Автоматизированный электропривод», имеющих специализации по робототехнике. И сегодня факультет остается единственным в республике центром подготовки специалистов в области робототехники.В то же время, в соответствии с требованиями сегодняшнего дня, расширяется подготовка специалистов в области информационных технологий и робототехники. Новое название наиболее полно отражает сложившуюся структуру специальностей направленность развития факультета."

        trayView.backgroundColor = R.color.elementBackground()
        expandView.backgroundColor = R.color.primaryColor()
        expandImageView.image = R.image.arrowUp()
        expandImageView.tintColor = .white
        expandImageView.contentMode = .scaleAspectFit

        specialtyTableView.delegate = self
        specialtyTableView.dataSource = self
        specialtyTableView.backgroundColor = R.color.elementBackground()
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
        navigationController?.pushViewController(SpecialtyDescriptionView(), animated: true)
    }
}

extension FacultyDescriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SpecialtyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
            cell.setup(shortName: "ПОИТ", fullName: "Программное обеспечение информационных технологий")
        }

        if indexPath.row == 1 {
            cell.setup(shortName: "ИСИТ", fullName: "ИНФОРМАЦИОННЫЕ СИСТЕМЫ И ТЕХНОЛОГИИ В ОБРАБОТКЕ И ПРЕДСТАВЛЕНИИ ИНФОРМАЦИИ")
        }

        if indexPath.row == 2 {
            cell.setup(shortName: "САПР", fullName: "ИНФОРМАЦИОННЫЕ СИСТЕМЫ И ТЕХНОЛОГИИ В ПРОЕКТИРОВАНИИ И ПРОИЗВОДСТВЕ")
        }
        return cell
    }
}
