//
//  UIView+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit
import SnapKit

public extension UIView {
  public static func container(_ insertedView: UIView,
                               centerHorizontally: Bool = false,
                               centerVertically: Bool = false,
                               insets: UIEdgeInsets = UIEdgeInsets(inset: 0)) -> UIView {
    let view = UIView()
    view.addSubview(insertedView)
    insertedView.snp.makeConstraints {
      if centerVertically {
        $0.centerY.leading.equalTo(view).inset(insets)
      } else if centerHorizontally {
        $0.centerX.top.bottom.equalTo(view).inset(insets)
      } else {
        $0.edges.equalTo(view).inset(insets)
      }
    }
    return view
  }
}
