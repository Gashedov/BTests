//
//  TestListContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import UIKit

protocol TestListRouter: AnyObject {
    func pushTestDescriotion(with: TestData)
}

protocol TestListBuilder {
    func build() -> UIViewController
}

protocol TestListViewModel {
    var items: [Test] { get }
    var delegate: TestListViewModelDelegate? { get set }
    
    func fetchItems()
    func openTestDescription(at: Int)
}

protocol TestListViewModelDelegate: AnyObject {
    func itemsFetched()
}


