//
//  File.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation
import UIKit

extension UILabel {
  public static func create(text: String = "",
                            numberOfLines: Int = 0,
                            textAlignment: NSTextAlignment = .center,
                            textColor: UIColor = .black,
                            font: UIFont) -> UILabel {
    
    let label = UILabel()
    label.text = text
    label.numberOfLines = numberOfLines
    label.textAlignment = textAlignment
    label.textColor = textColor
    label.font = font
    return label
  }
}

extension UILabel {
  public func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
    guard let labelText = self.text else { return }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    paragraphStyle.alignment = self.textAlignment
    
    let attributedString:NSMutableAttributedString
    if let labelattributedText = self.attributedText {
      attributedString = NSMutableAttributedString(attributedString: labelattributedText)
    } else {
      attributedString = NSMutableAttributedString(string: labelText)
    }
    
    attributedString
      .addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    
    self.attributedText = attributedString
  }
}
