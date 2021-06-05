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
        navigationController?.pushViewController(TestsListView(), animated: true)
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
        if indexPath.row == 0 {
        cell.setupValues(name: "ПСФ", fullName: "Приборостроительный факультет", description: "Начало подготовки специалистов приборостроительного направления в БПИ-БГПА-БНТУ было положено в 1961 году созданием кафедры «Приборы точной механики». Ее первым заведующим, который возглавлял кафедру на протяжении 23 лет, был заслуженный работник высшей школы БССР, профессор С.С. Костюкович.Развитие оптической промышленности сделало необходимым открытие в 1976 году оптико-механического факультета, который в разной время возглавляли доцент Р.И. Томилин, доцент В.И. Клецко, профессор М.Г. Киселев. В связи с дальнейшим расширением перечня востребованных приборостроительных специальностей в 1978 году был открыт инженерно-физический факультет, деканами которого были профессор Г.С. Круглик и доцент А.Г. Литвинко. В 1984 году оптико-механический и инженерно-физический факультеты были объединены в один – инженерно-физический, который в следующем году был переименован в приборостроительный факультет")

        }
        if indexPath.row == 1 {
            cell.setupValues(name: "ФИТР", fullName: "Приборостроительный факультет", description: "LНачало подготовки специалистов приборостроительного направления в БПИ-БГПА-БНТУ было положено в 1961 году созданием кафедры «Приборы точной механики». Ее первым заведующим, который возглавлял кафедру на протяжении 23 лет, был заслуженный работник высшей школы БССР, профессор С.С. Костюкович.Развитие оптической промышленности сделало необходимым открытие в 1976 году оптико-механического факультета, который в разной время возглавляли доцент Р.И. Томилин, доцент В.И. Клецко, профессор М.Г. Киселев. В связи с дальнейшим расширением перечня востребованных приборостроительных специальностей в 1978 году был открыт инженерно-физический факультет, деканами которого были профессор Г.С. Круглик и доцент А.Г. Литвинко. В 1984 году оптико-механический и инженерно-физический факультеты были объединены в один – инженерно-физический, который в следующем году был переименован в приборостроительный факультет")
        }
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
        titleLabel.text = "Найди себя"

        searchBarContainer.backgroundColor = .white
        searchBarContainer.layer.cornerRadius = 20

        searchBar.tintColor = .lightGray
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        //searchBar.setSearchFieldBackgroundImage(R.image.searchLine(), for: .normal)

        searchBarBottomBorder.backgroundColor = .lightGray
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
