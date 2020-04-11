//
//  String+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

extension String {
  public func replaceLastOccurance(_ searchString: String,
                                   with replacementString: String,
                                   caseInsensitive: Bool = true) -> String {
    let options: String.CompareOptions
    if caseInsensitive {
      options = [.backwards, .caseInsensitive]
    } else {
      options = [.backwards]
    }
    
    if let range = self.range(of: searchString,
                              options: options,
                              range: nil,
                              locale: nil) {
      
      return self.replacingCharacters(in: range, with: replacementString)
    }
    return self
  }
  
  public func replaceFirstOccurance(target: String, withString replaceString: String) -> String {
    if let range = self.range(of: target) {
      return self.replacingCharacters(in: range, with: replaceString)
    }
    return self
  }
}

