//
//  PaddingLabel.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

public final class PaddingLabel: UILabel {
  private struct AssociatedKeys {
    static var padding = UIEdgeInsets()
  }
  
  public var padding: UIEdgeInsets? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
    }
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  public override func draw(_ rect: CGRect) {
    if let insets = padding {
      self.drawText(in: rect.inset(by: insets))
    } else {
      self.drawText(in: rect)
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    guard let text = self.text else { return super.intrinsicContentSize }
    
    var contentSize = super.intrinsicContentSize
    var textWidth: CGFloat = frame.size.width
    var insetsHeight: CGFloat = 0.0
    var insetsWidth: CGFloat = 0.0
    
    if let insets = padding {
      insetsWidth += insets.left + insets.right
      insetsHeight += insets.top + insets.bottom
      textWidth -= insetsWidth
    }
    
    let customFont: UIFont = font ?? .systemFont(ofSize: 16, weight: .regular)
    let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: [.font: customFont],
                                    context: nil)
    
    contentSize.height = ceil(newSize.size.height) + insetsHeight
    contentSize.width = ceil(newSize.size.width) + insetsWidth
    
    return contentSize
  }
  
}

