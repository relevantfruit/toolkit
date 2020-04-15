//
//  UIButton+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation
import UIKit

public extension UIButton {
  static func create(numberOfLines: Int? = 0,
                            horizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
                            verticalAlignment: UIControl.ContentVerticalAlignment = .center,
                            backgroundColor: UIColor? = .clear,
                            backgroundImage: UIImage? = nil,
                            image: UIImage? = nil,
                            title: String? = "",
                            titleColor: UIColor? = .white,
                            font: UIFont? = .boldSystemFont(ofSize: 17.0)) -> UIButton {
    
    let button = UIButton(type: .custom)
    button.titleLabel?.numberOfLines = 0
    button.backgroundColor = backgroundColor
    button.contentHorizontalAlignment = horizontalAlignment
    button.contentVerticalAlignment = verticalAlignment
    button.setTitleColor(titleColor, for: .normal)
    button.setBackgroundImage(backgroundImage, for: .normal)
    button.setImage(image, for: .normal)
    button.titleLabel?.font = font
    button.setTitle(title, for: .normal)
    return button
  }
}
