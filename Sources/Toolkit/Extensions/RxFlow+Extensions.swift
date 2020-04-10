//
//  RxFlow+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

import UIKit
import Reusable

public protocol ServicesViewModel: ViewModel {
  associatedtype Services
  public var services: Services! { get set }
}

public protocol ViewModelBased: class {
  associatedtype ViewModelType: ViewModel
  public var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController {
  public static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
    let viewController = Self.init()
    viewController.viewModel = viewModel
    return viewController
  }
}

extension ViewModelBased where Self: UIViewController, ViewModelType: ServicesViewModel {
  public static func instantiate<ViewModelType, ServicesType> (withViewModel viewModel: ViewModelType, andServices services: ServicesType) -> Self
    where ViewModelType == Self.ViewModelType, ServicesType == Self.ViewModelType.Services {
      let viewController = Self.init()
      viewController.viewModel = viewModel
      viewController.viewModel.services = services
      return viewController
  }
}
