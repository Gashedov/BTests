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
    private let cardTableView = UITableView(frame: .zero, style: .grouped)
    private let testButton = UIButton()

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.backgroundColor = .lightGray

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
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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

        testButton.setTitle("Test", for: .normal)
        testButton.backgroundColor = .black
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
        navigationController?.pushViewController(FacultyDescriptionView(), animated: true)
    }
}

extension MainScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FacultyCardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupValues(name: "ПСФ", fullName: "Приборостроительный факультет", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tempus nisi arcu, eu lacinia tortor euismod vel. Aliquam vestibulum non lectus id pretium. Vestibulum vel pretium orci. Phasellus condimentum, arcu quis bibendum malesuada, felis libero suscipit mauris, id efficitur justo sem vitae tortor. Sed augue massa, luctus sed pellentesque ut, fringilla nec neque. Mauris eleifend augue nec magna fringilla, ac porttitor diam tristique. Aliquam erat volutpat. Ut a nisi velit. Nam diam lacus, pretium ut dictum nec, facilisis ut quam. Curabitur varius tellus eget viverra lobortis. Phasellus semper massa sed ornare hendrerit. Aliquam in ullamcorper massa. Mauris consectetur ipsum ac massa vulputate ornare.")
        return cell
    }
}

extension MainScreenView: UISearchBarDelegate {

}

class SearchTableViewHeader: UITableViewHeaderFooterView, ReuseIdentifiable {
    private let titleLabel = UILabel()
    private let searchBarContainer = UIView()
    private let searchBar = UISearchBar()
    private let searchBarBottomBorder = UIView()

    var searchDelegate: UISearchBarDelegate? {
        willSet {
            searchBar.delegate = newValue
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
        }

        addSubview(searchBarContainer)
        searchBarContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }

        searchBarContainer.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        searchBarContainer.addSubview(searchBarBottomBorder)
        searchBarBottomBorder.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalTo(searchBar).inset(14)
            $0.height.equalTo(1)
        }

        backgroundColor = .clear

        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.text = "Find your way"

        searchBarContainer.backgroundColor = .white
        searchBarContainer.layer.cornerRadius = 20

        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.setSearchFieldBackgroundImage(R.image.searchLine(), for: .normal)

        searchBarBottomBorder.backgroundColor = .lightGray
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
