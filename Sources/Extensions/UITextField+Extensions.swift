//
//  UITextField+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation
import UIKit

extension UITextField {
  static public func create(font: UIFont = .boldSystemFont(ofSize: 17.0),
                            placeholder: String = "",
                            placeholderColor: UIColor = .lightGray,
                            textColor: UIColor = .white,
                            tintColor: UIColor = .black,
                            backgroundColor: UIColor = .clear,
                            borderStyle: UITextField.BorderStyle = .none,
                            textAlignment: NSTextAlignment = .left,
                            returnKeyType: UIReturnKeyType = .default) -> UITextField {
    
    let textField = UITextField()
    textField.font = font
    textField.placeholder = placeholder
    textField.textColor = textColor
    textField.tintColor = tintColor
    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
      .foregroundColor: placeholderColor
    ])
    textField.backgroundColor = backgroundColor
    textField.borderStyle = borderStyle
    textField.textAlignment = textAlignment
    textField.returnKeyType = returnKeyType
    return textField
  }
}
