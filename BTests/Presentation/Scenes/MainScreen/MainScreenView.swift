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
    private let cardCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UPCarouselFlowLayout()
    )

    // MARK: - Life cucle methods
    override func loadView() {
        view = UIView()

        view.backgroundColor = .lightGray

        view.addSubview(cardCollectionView)
        cardCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK: - Private methods
    private func setupUI() {
        cardCollectionView.backgroundColor = .clear
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.showsHorizontalScrollIndicator = false
        cardCollectionView.register(FacultyCardCollectionViewCell.self)
        cardCollectionView.registerHeaderView(SearchCollectionViewHeader.self)

        let layout = cardCollectionView.collectionViewLayout as? UPCarouselFlowLayout
        layout?.sideItemScale = 1
        layout?.sideItemAlpha = 1
        layout?.scrollDirection = .vertical
    }
}

extension MainScreenView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header: SearchCollectionViewHeader = collectionView.dequeueReusableHeaderView(for: indexPath)
        header.searchDelegate = self
        return header
    }
}

extension MainScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FacultyCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupValues(name: "ПСФ", fullName: "Приборостроительный факультет", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tempus nisi arcu, eu lacinia tortor euismod vel. Aliquam vestibulum non lectus id pretium. Vestibulum vel pretium orci. Phasellus condimentum, arcu quis bibendum malesuada, felis libero suscipit mauris, id efficitur justo sem vitae tortor. Sed augue massa, luctus sed pellentesque ut, fringilla nec neque. Mauris eleifend augue nec magna fringilla, ac porttitor diam tristique. Aliquam erat volutpat. Ut a nisi velit. Nam diam lacus, pretium ut dictum nec, facilisis ut quam. Curabitur varius tellus eget viverra lobortis. Phasellus semper massa sed ornare hendrerit. Aliquam in ullamcorper massa. Mauris consectetur ipsum ac massa vulputate ornare.")
        return cell
    }
}

extension MainScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 240, height: 240)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension MainScreenView: UISearchBarDelegate {

}

class SearchCollectionViewHeader: UICollectionReusableView, ReuseIdentifiable {
    private let titleLabel = UILabel()
    private let searchBarContainer = UIView()
    private let searchBar = UISearchBar()
    private let searchBarBottomBorder = UIView()

    var searchDelegate: UISearchBarDelegate? {
        willSet {
            searchBar.delegate = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
