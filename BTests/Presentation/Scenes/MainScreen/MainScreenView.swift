//
//  MainScreenView.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.05.21.
//

import UIKit
import UPCarouselFlowLayout

class MainScreenView: UIViewController {

    // MARK: - Properties
    private let backgroundView = GradientedView()
    private let cardTableView = UITableView(frame: .zero, style: .grouped)
    private let testButton = UIButton()

    var viewModel: MainScreenViewModel?

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(cardTableView)
        cardTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.fetchItems()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.applyGradient(
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1.5),
            colorArray: [R.color.primaryColor(), .black]
        )
    }

    //MARK: - Private methods
    private func setupUI() {
        cardTableView.separatorStyle = .none
        cardTableView.backgroundColor = .clear
        cardTableView.rowHeight = 400
        cardTableView.delegate = self
        cardTableView.dataSource = self
        cardTableView.showsHorizontalScrollIndicator = false
        cardTableView.register(FacultyCardTableViewCell.self)
        cardTableView.registerHeaderFooter(SearchTableViewHeader.self)

        testButton.setTitle("Тест", for: .normal)
        testButton.backgroundColor = R.color.minorColor()
        testButton.addTarget(self, action: #selector(openTest), for: .touchUpInside)
    }

    @objc func openTest() {
        viewModel?.openTestList()
    }
}

extension MainScreenView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header: SearchTableViewHeader = tableView.dequeueReusableHeaderFooterView()
        header.searchDelegate = self
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openFacultyDescription(forItemAt: indexPath.row)
    }
}

extension MainScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FacultyCardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        guard let item = viewModel?.items[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupValues(name: item.name, fullName: item.fullName, description: item.description)
        return cell
    }
}

extension MainScreenView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false

        // Remove focus from the search bar.
        searchBar.endEditing(true)

        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
}

extension MainScreenView: MainScreenViewModelDelegate {
    func itemsFetched() {
        cardTableView.reloadData()
    }
}
