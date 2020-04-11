//
//  Sequence+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
  public func sum() -> Element {
    return reduce(.zero, +)
  }
}
