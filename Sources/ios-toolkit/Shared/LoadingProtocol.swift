//
//  LoadingProtocol.swift
//  Instosh
//
//  Created by Rufat Mirza on 13.08.2019.
//  Copyright © 2019 Rufat Mirza. All rights reserved.
//
import RxSwift
import RxCocoa
import SwiftEntryKit
import UIKit

public protocol ErrorDisplayer {
    var errorMessage: Binder<ErrorObject> { get }
}

public protocol RemoteLoading {
    var isLoading: BehaviorRelay<Bool> { get }
    var onError: BehaviorRelay<ErrorObject?> { get }
}

public protocol ViewModel {}

public protocol View {
    associatedtype VM: ViewModel
    var viewModel: VM { get }
    var bag: DisposeBag { get }
}

public extension View where Self: LoadingHandler, Self.VM: RemoteLoading {
    func bindLoading() {
        viewModel.isLoading
            .asObservable()
            .subscribe(onNext: { isLoading in
                isLoading ? self.showLoading() : self.hideLoading()
            }).disposed(by: bag)
    }
}

public extension View where Self: ErrorDisplayer, Self.VM: RemoteLoading {
    func bindErrorHandling() {
        viewModel.onError
            .asObservable()
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: errorMessage)
            .disposed(by: bag)
    }
}

public extension ErrorDisplayer where Self: UIViewController {
    var errorMessage: Binder<ErrorObject> {
        return Binder.init(self, binding: { (controller, errorObject) in
            let imageSize = CGSize(width: 40, height: 40)
            
            var imageColor = UIColor(hex: 0x079992)!
            var thumbnailImage = UIImage()
            
            if errorObject.warningType != .success {
                let isError = errorObject.warningType == .error
                imageColor = isError ? UIColor(hex: 0xeb2f06)! : UIColor(hex: 0xe58e26)!
                thumbnailImage = UIImage()
            }
            
            let title = EKProperty.LabelContent(
                text: errorObject.errorTitle,
                style: .init(
                    font: UIFont.systemFont(ofSize: 18, weight: .bold),
                    color: .black,
                    displayMode: .inferred
                ),
                accessibilityIdentifier: "title"
            )
            let description = EKProperty.LabelContent(
                text: errorObject.errorDescription,
                style: .init(
                    font: UIFont.systemFont(ofSize: 16),
                    color: .black,
                    displayMode: .inferred
                ),
                accessibilityIdentifier: "description"
            )
            let image: EKProperty.ImageContent = EKProperty.ImageContent(
                image: thumbnailImage.withRenderingMode(.alwaysTemplate),
                displayMode: .inferred,
                size: imageSize,
                tint: EKColor(imageColor),
                accessibilityIdentifier: "thumbnail"
            )
            let simpleMessage = EKSimpleMessage(
                image: image,
                title: title,
                description: description
            )
            let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
            let contentView = EKNotificationMessageView(with: notificationMessage)
            var attributes = EKAttributes.topToast
            attributes.entryBackground = .visualEffect(style: .init(style: .extraLight))
            attributes.displayDuration = 4
            SwiftEntryKit.display(entry: contentView, using: attributes)
        })
    }
    
}
