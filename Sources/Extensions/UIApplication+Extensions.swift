//
//  UIApplication+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

public extension UIApplication {
  class var mainWindow: UIWindow {
    return self.shared.keyWindow ?? UIWindow()
  }
}
