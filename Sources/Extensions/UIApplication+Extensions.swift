//
//  UIApplication+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

extension UIApplication {
  public class var mainWindow: UIWindow {
    return self.shared.keyWindow ?? UIWindow()
  }
}
