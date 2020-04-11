//
//  Array+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation

extension Array {
  public func at(index: Int) -> Element? {
    if index < 0 || index > self.count - 1 {
      return nil
    }
    return self[index]
  }
}
