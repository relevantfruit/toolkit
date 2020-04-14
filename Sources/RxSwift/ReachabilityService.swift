//
//  ReachabilityService.swift
//  RxExample
//
//  Created by Vodovozov Gleb on 10/22/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//
#if canImport(RxSwift)
import RxSwift
import Reachability
import Foundation

import class Dispatch.DispatchQueue

public enum ReachabilityStatus {
  case reachable
  case unreachable
}

extension ReachabilityStatus {
  public var reachable: Bool {
    switch self {
    case .reachable:
      return true
    case .unreachable:
      return false
    }
  }
}

public protocol HasReachabilityService {
  var reachability: Observable<ReachabilityStatus> { get }
}

public enum ReachabilityServiceError: Error {
  case failedToCreate
}

public class DefaultReachabilityService: HasReachabilityService {
  private let _reachabilitySubject: BehaviorSubject<ReachabilityStatus>
  
  public var reachability: Observable<ReachabilityStatus> {
    return _reachabilitySubject.asObservable()
  }
  
  public let _reachability: Reachability
  
  public init() throws {
    guard let reachabilityRef = try? Reachability() else { throw ReachabilityServiceError.failedToCreate }
    let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)
    
    // so main thread isn't blocked when reachability via WiFi is checked
    let backgroundQueue = DispatchQueue(label: "reachability.wificheck")
    
    reachabilityRef.whenReachable = { reachability in
      backgroundQueue.async {
        reachabilitySubject.on(.next(.reachable))
      }
    }
    
    reachabilityRef.whenUnreachable = { reachability in
      backgroundQueue.async {
        reachabilitySubject.on(.next(.unreachable))
      }
    }
    
    try reachabilityRef.startNotifier()
    _reachability = reachabilityRef
    _reachabilitySubject = reachabilitySubject
  }
  
  deinit {
//    _reachability.stopNotifier()
  }
}

extension ObservableConvertibleType {
  public func retryOnBecomesReachable(_ valueOnFailure:Element, reachabilityService: DefaultReachabilityService) -> Observable<Element> {
    return self.asObservable()
      .catchError { (e) -> Observable<Element> in
        reachabilityService.reachability
          .skip(1)
          .filter { $0.reachable }
          .flatMap { _ in
            Observable.error(e)
        }
        .startWith(valueOnFailure)
    }
    .retry()
  }
}
#endif
