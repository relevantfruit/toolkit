//
//  UINavigationBar+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

extension UINavigationBar {
  public func makeTransparent() {
    setBackgroundImage(UIImage(), for: .default)
    shadowImage = UIImage()
    isTranslucent = true
    
    if #available(iOS 13.0, *) {
      let appereance = UINavigationBarAppearance()
      appereance.configureWithTransparentBackground()
      standardAppearance = appereance
      scrollEdgeAppearance = appereance
      compactAppearance = appereance
    }
  }
}
