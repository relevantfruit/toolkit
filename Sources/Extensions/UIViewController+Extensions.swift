//
//  UIViewController+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

public extension UIViewController {
  func configureNavBar(with title: String, prefersLargeTitle: Bool = true) {
    navigationItem.title = title
    if #available(iOS 11.0, *) {
      if prefersLargeTitle {
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
      } else {
        navigationItem.largeTitleDisplayMode = .never
      }
    }
  }
}
