//
//  File.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit

public class RoundImageView: UIImageView {
  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.size.width / 2.0
    self.layer.masksToBounds = true
  }
}
