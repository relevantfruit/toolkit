//
//  UIImagePickerController+Extensions.swift
//  
//
//  Created by yagiz on 4/11/20.
//

#if canImport(RxCocoa) && canImport(RxSwift) && canImport(RxCocoaRuntime)
import RxSwift
import RxCocoa
import UIKit

public extension Reactive where Base: UIImagePickerController {
  /**
   Reactive wrapper for `delegate` message.
   */
  var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: Any]> {
    return delegate
      .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
      .map({ (a) in
        return try castOrThrow(Dictionary<UIImagePickerController.InfoKey, Any>.self, a[1])
      })
  }
  
  /**
   Reactive wrapper for `delegate` message.
   */
  var didCancel: Observable<()> {
    return delegate
      .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
      .map {_ in () }
  }
}

private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }
  
  return returnValue
}

open class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
  
  public init(imagePicker: UIImagePickerController) {
    super.init(navigationController: imagePicker)
  }
  
}

#endif
