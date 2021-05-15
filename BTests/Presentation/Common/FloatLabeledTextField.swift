//
//  FloatLabeledTextField.swift
//  BTests
//
//  Created by Artem Gorshkov on 12.05.21.
//

import UIKit

class FloatLabelTextField: UITextField {
    // MARK:- Properties
    let animationDuration = 0.3
    var title = UILabel()

    override var accessibilityLabel: String? {
        get {
            if let text = text, text.isEmpty {
                return title.text
            }
            return text
        }
        set {
            self.accessibilityLabel = newValue
        }
    }

    override var placeholder: String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }

    override var attributedPlaceholder: NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }

    var titleFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }

    var hintYPadding: CGFloat = 0.0

    var titleYPadding: CGFloat = 0.0 {
        didSet {
            var frame = title.frame
            frame.origin.y = titleYPadding
            title.frame = frame
        }
    }

    var titleTextColour: UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }

   var titleActiveTextColour: UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        if let text = text, !text.isEmpty && isFirstResponder {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        if let text = text, text.isEmpty {
            hideTitle(isFirstResponder)
        } else {
            showTitle(isFirstResponder)
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rectangle = super.textRect(forBounds: bounds)
        if let text = text, !text.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            rectangle = rectangle.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return rectangle.integral
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rectangle = super.editingRect(forBounds: bounds)
        if let text = text, !text.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            rectangle = rectangle.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return rectangle.integral
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rectangle = super.clearButtonRect(forBounds: bounds)
        if let text = text, !text.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            rectangle = CGRect(
                x: rectangle.origin.x,
                y: rectangle.origin.y + (top * 0.5),
                width: rectangle.size.width,
                height: rectangle.size.height
            )
        }
        return rectangle.integral
    }

    // MARK:- Private Methods
    private func setup() {
        borderStyle = .none
        titleActiveTextColour = tintColor
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let placeholder = placeholder , !placeholder.isEmpty {
            title.text = placeholder
            title.sizeToFit()
        }
        self.addSubview(title)
    }

    private func maxTopInset() -> CGFloat {
        if let font = font {
            return max(0, floor(bounds.size.height - font.lineHeight - 4.0))
        }
        return 0
    }

    private func setTitlePositionForTextAlignment() {
        let textRectangle = textRect(forBounds: bounds)
        var x = textRectangle.origin.x
        if textAlignment == .center {
            x = textRectangle.origin.x + (textRectangle.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == .right {
            x = textRectangle.origin.x + textRectangle.size.width - title.frame.size.width
        }
        title.frame = CGRect(
            x: x,
            y: title.frame.origin.y,
            width: title.frame.size.width,
            height: title.frame.size.height
        )
    }

    private func showTitle(_ animated: Bool) {
        let duration = animated ? animationDuration : 0
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseOut]
        ) {
            self.title.alpha = 1.0
            var frame = self.title.frame
            frame.origin.y = self.titleYPadding
            self.title.frame = frame
        }
    }

    private func hideTitle(_ animated: Bool) {
        let duration = animated ? animationDuration : 0
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.beginFromCurrentState, .curveEaseIn]
        ) {
            self.title.alpha = 0.0
            var frame = self.title.frame
            frame.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = frame
        }
    }
}
