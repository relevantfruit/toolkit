//
//  UIStackView+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

extension UIStackView {
  static public func create(arrangedSubViews: [UIView] = [],
                            axis: NSLayoutConstraint.Axis = .vertical,
                            alignment: UIStackView.Alignment = .fill,
                            distribution: UIStackView.Distribution = .fill,
                            spacing: CGFloat = .leastNormalMagnitude) -> UIStackView {
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
    stackView.axis = axis
    stackView.alignment = alignment
    stackView.distribution = distribution
    stackView.spacing = spacing
    return stackView
  }
}
