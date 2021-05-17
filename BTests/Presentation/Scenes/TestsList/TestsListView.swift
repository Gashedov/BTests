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

    // MARK: - Private methods
    private func setupUI() {
        tableView.register(TestTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
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
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(title: "Test type \(indexPath.row)")
        return cell
    }
}
