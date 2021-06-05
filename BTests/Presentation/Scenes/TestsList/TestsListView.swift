//
//  TestsListView.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.05.21.
//

import UIKit

class TestsListView: UIViewController {
    //MARK: - Properties
    let tableView = UITableView()

    //MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = R.color.primaryColor()

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

    // MARK: - Private methods
    private func setupUI() {
        tableView.register(TestTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.color.elementBackground()
        tableView.rowHeight = 80
    }
}

extension TestsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(TestDescriptionView(), animated: true)
    }
}

extension TestsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
        cell.setup(title: "ТЕСТ: Какой факультет мне подходит")
    }
        if indexPath.row == 1 {
        cell.setup(title: "ТЕСТ: Какая специальность мне подходит")
            cell.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
        return cell
    }
}
