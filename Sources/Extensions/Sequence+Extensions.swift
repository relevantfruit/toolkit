//
//  Sequence+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation

public extension Sequence where Element: AdditiveArithmetic {
  func sum() -> Element {
    return reduce(.zero, +)
  }
}
