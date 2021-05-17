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

    private let trayViewOffset: CGFloat = 50

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

        view.addSubview(trayView)
        trayView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.snp.bottom).inset(trayViewOffset)
            $0.height.equalTo(400)
        }

        trayView.addSubview(expandView)
        expandView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        trayView.addSubview(specialtyTableView)
        specialtyTableView.snp.makeConstraints {
            $0.top.equalTo(expandView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        expandView.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(expandView.snp.height).inset(4)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        trayView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragView)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupUI() {
        view.backgroundColor = .lightGray

        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "Faculty name"

        fullNameLabel.textAlignment = .center
        fullNameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        fullNameLabel.numberOfLines = 2
        fullNameLabel.text = "Full name of faculty"

        descriptionLabel.font = .systemFont(ofSize: 24)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam efficitur sapien nulla, vitae sodales sapien ultrices et. Morbi velit sem, bibendum vitae cursus ac, iaculis id massa. Maecenas iaculis enim nec arcu commodo porta. Etiam accumsan maximus augue vitae tempus. Vestibulum ac est purus. Etiam ut erat ullamcorper, bibendum metus in, volutpat quam. Donec varius at tellus ac pretium. Cras quam purus, tristique nec ipsum a, hendrerit iaculis ante. Integer pulvinar sodales neque, nec consequat nisi pulvinar non. Quisque ullamcorper nunc vel dolor interdum, a laoreet justo tincidunt. Duis at tempus mi. Proin id consectetur dolor. Maecenas nisl felis, gravida vitae quam vitae, placerat pharetra enim. Suspendisse ultricies imperdiet ante molestie accumsan. Donec mollis eleifend tortor, ac lobortis quam eleifend et."

        trayView.backgroundColor = .white
        expandView.backgroundColor = .darkGray
        expandImageView.backgroundColor = .black
    }

    @objc private func dragView(gesture: UIPanGestureRecognizer) {
        guard let target = gesture.view else { return }
        let velocity = gesture.velocity(in: self.view).y/50
        let alignmentYValue = (view.bounds.maxY-trayViewOffset)/2

        switch gesture.state {
        case .changed:
            UIView.animate(withDuration: 0.25) {
                guard target.frame.minY > self.view.bounds.minY-10 else {
                    target.center.y = self.view.center.y
                    return
                }
                target.center = CGPoint(x: target.center.x, y: target.center.y + velocity)
            }
        case .ended:
            UIView.animate(withDuration: 0.25) {
                if target.frame.minY < self.view.bounds.minY ||
                    target.frame.minY+velocity < alignmentYValue {
                    target.center.y = self.view.center.y
                }
                if target.frame.minY+velocity > alignmentYValue {
                    target.center.y = self.view.center.y+self.trayViewOffset
                }
            }
        default:
            break
        }
    }
}
