//
//  MainScreenContract.swift
//  BTests
//
//  Created by Artem Gorshkov on 15.06.21.
//

import Foundation


import UIKit

protocol MainScreenRouter: AnyObject {
    func pushFacultyDescription(for : FacultyData)
    func pushTestList()
}

protocol MainScreenBuilder {
    func build() -> UIViewController
}

protocol MainScreenViewModel {
    var items: [Faculty] { get }
    var delegate: MainScreenViewModelDelegate? { get set }
    
    func fetchItems()
    func openTestList()
    func openFacultyDescription(forItemAt: Int)
}

protocol MainScreenViewModelDelegate: AnyObject {
    func itemsFetched()
}
