//
//  File.swift
//  
//
//  Created by yagiz on 4/15/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

public protocol LoadableView where Self: UIView {
  func startAnimation()
  init()
}

public protocol LoadableController {
  var LoadingViewType: LoadableView.Type { get }
}

public extension Reactive where Base: UIViewController, Base: LoadableController {
  var showLoading: Binder<Bool> {
    return Binder(base, binding: { (target, isLoading) in
      if isLoading {
        if target.view.subviews.contains(where: { $0 is LoadableView }) { return }
        let loadingView = target.LoadingViewType.init()
        target.view.addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalTo(target.view) }
        loadingView.startAnimation()
      } else {
        target.view.subviews
          .filter { $0 is LoadableView }
          .forEach { $0.removeFromSuperview() }
      }
    })
  }
}
