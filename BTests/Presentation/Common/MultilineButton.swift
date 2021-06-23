//
//  MultilineButton.swift
//  BTests
//
//  Created by Artem Gorshkov on 22.06.21.
//

import UIKit

class MultiLineButton: UIButton {

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.lineBreakMode = .byWordWrapping
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides

    override var intrinsicContentSize: CGSize {
        get {
             return titleLabel?.intrinsicContentSize ?? CGSize.zero
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.preferredMaxLayoutWidth = titleLabel?.frame.size.width ?? 0
        super.layoutSubviews()
    }

}
