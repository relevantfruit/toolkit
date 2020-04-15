//
//  UIFont+Extensions.swift
//  
//
//  Created by yagiz on 4/15/20.
//

import UIKit

extension UIFont {
  func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
    return NSString(string: string).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: self],
                                                 context: nil).size
  }
}
