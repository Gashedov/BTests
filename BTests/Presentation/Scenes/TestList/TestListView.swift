//
//  TestsListView.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.05.21.
//

import UIKit

class TestListView: UIViewController {
    //MARK: - Properties
    let tableView = UITableView()

    var viewModel: TestListViewModel?

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
        viewModel?.fetchItems()
        viewModel?.delegate = self
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

extension TestListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openTestDescription(at: indexPath.row)
    }
}

extension TestListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let item = viewModel?.items[indexPath.row] else { return UITableViewCell() }
        cell.setup(title: item.testName)
        return cell
    }
}

extension TestListView: TestListViewModelDelegate {
    func itemsFetched() {
        tableView.reloadData()
    }
}
