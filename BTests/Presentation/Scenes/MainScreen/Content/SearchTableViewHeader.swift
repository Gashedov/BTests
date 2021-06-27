//
//  SearchTableViewHeader.swift
//  BTests
//
//  Created by Artem Gorshkov on 9.06.21.
//

import UIKit

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
        titleLabel.text = R.string.localizable.findYourself()

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
