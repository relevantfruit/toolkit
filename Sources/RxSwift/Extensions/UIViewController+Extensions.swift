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

extension Reactive where Base: UIViewController {
  var showLoading: Binder<Bool> {
    return Binder(base, binding: { (target, isLoading) in
      if isLoading {
        let loadingView = LoadingView()
        target.view.addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalTo(target.view) }
        loadingView.start()
      } else {
        target.view.subviews
          .filter { $0 is LoadingView }
          .forEach { $0.removeFromSuperview() }
      }
    })
  }
}

