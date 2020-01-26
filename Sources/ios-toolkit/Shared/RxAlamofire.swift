//
//  RxAlamofire.swift
//  socialkit
//
//  Created by yagiz on 1/23/20.
//  Copyright © 2020 yagiz. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper
import Alamofire
import UIKit

public let RxAlamofireObjectMapperMapError = NSError(domain: "RxAlamofireObjectMapperDomain", code: -1, userInfo: nil)

public extension Reactive where Base: DataRequest {
    
    func responseMappable<T: Mappable>(`as` type: T.Type? = nil, to object: T? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<T> {
        return self.responseJSON()
            .mappable(as: type, to: object, keyPath: keyPath, context: context)
    }
    
    func responseMappableArray<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[T]> {
        return self.responseJSON()
            .mappableArray(as: type, keyPath: keyPath, context: context)
    }
    
    func responseMappableDictionary<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:T]> {
        return self.responseJSON()
            .mappableDictionary(as: type, keyPath: keyPath, context: context)
    }
    
    func responseMappableDictionaryOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:[T]]> {
        return self.responseJSON()
            .mappableDictionaryOfArrays(as: type, keyPath: keyPath, context: context)
    }
    
    func responseMappableArrayOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[[T]]> {
        return self.responseJSON()
            .mappableArrayOfArrays(as: type, keyPath: keyPath, context: context)
    }
}

extension Observable where Element == DataRequest {
    
    public func responseMappable<T: Mappable>(`as` type: T.Type? = nil, to object: T? = nil, context: MapContext? = nil, keyPath: String? = nil) -> Observable<T> {
        return self.flatMapLatest { $0.rx.responseMappable(as: type, to: object, keyPath: keyPath, context: context) }
    }
    
    public func responseMappableArray<T: Mappable>(`as` type: T.Type? = nil, context: MapContext? = nil, keyPath: String? = nil) -> Observable<[T]> {
        return self.flatMapLatest { $0.rx.responseMappableArray(as: type, keyPath: keyPath, context: context) }
    }
    
    public func responseMappableDictionary<T: Mappable>(`as` type: T.Type? = nil, context: MapContext? = nil, keyPath: String? = nil) -> Observable<[String:T]> {
        return self.flatMapLatest { $0.rx.responseMappableDictionary(as: type, keyPath: keyPath, context: context) }
    }
    
    public func responseMappableDictionaryOfArrays<T: Mappable>(`as` type: T.Type? = nil, context: MapContext? = nil, keyPath: String? = nil) -> Observable<[String:[T]]> {
        return self.flatMapLatest { $0.rx.responseMappableDictionaryOfArrays(as: type, keyPath: keyPath, context: context) }
    }
    
    public func responseMappableArrayOfArrays<T: Mappable>(`as` type: T.Type? = nil, context: MapContext? = nil, keyPath: String? = nil) -> Observable<[[T]]> {
        return self.flatMapLatest { $0.rx.responseMappableArrayOfArrays(as: type, keyPath: keyPath, context: context) }
    }
}

extension ObservableType where Element == (HTTPURLResponse, Any) {
    
    private func mapper<T: Mappable>(_ type: T.Type? = nil, from object: Any, keyPath: String? = nil, context: MapContext? = nil) -> (mapper: Mapper<T>, object: Any?) {
        var object: Any? = object
        if let keyPath = keyPath,
            let JSON = object as? [String:Any] {
            object = try? Map(mappingType: .fromJSON, JSON: JSON).value(keyPath)
        }
        let mapper = Mapper<T>()
        mapper.context = context
        return (mapper, object)
    }
    
    public func mappable<T: Mappable>(`as` type: T.Type? = nil, to object: T? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<T> {
        return self
            .flatMapLatest { _, json -> Observable<T> in
                let tempObject: T?
                let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
                if let object = object {
                    tempObject = mapper.mapper.map(JSONObject: mapper.object, toObject: object)
                } else {
                    tempObject = mapper.mapper.map(JSONObject: mapper.object)
                }
                guard let object = tempObject else {
                    return .error(RxAlamofireObjectMapperMapError)
                }
                return .just(object)
        }
    }
    
    public func mappableArray<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[T]> {
        return self
            .flatMapLatest { _, json -> Observable<[T]> in
                let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
                return .just(mapper.mapper.mapArray(JSONObject: mapper.object) ?? [])
        }
    }
    
    public func mappableDictionary<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:T]> {
        return self
            .flatMapLatest { _, json -> Observable<[String:T]> in
                let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
                return .just(mapper.mapper.mapDictionary(JSONObject: mapper.object) ?? [:])
        }
    }
    
    public func mappableDictionaryOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:[T]]> {
        return self
            .flatMapLatest { _, json -> Observable<[String:[T]]> in
                let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
                return .just(mapper.mapper.mapDictionaryOfArrays(JSONObject: mapper.object) ?? [:])
        }
    }
    
    public func mappableArrayOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[[T]]> {
        return self
            .flatMapLatest { _, json -> Observable<[[T]]> in
                let mapper = self.mapper(type, from: json, keyPath: keyPath, context: context)
                return .just(mapper.mapper.mapArrayOfArrays(JSONObject: mapper.object) ?? [])
        }
    }
}

extension ObservableType where Element == (HTTPURLResponse, [String: Any]) {
    
    public func mappable<T: Mappable>(`as` type: T.Type? = nil, to object: T? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<T> {
        return self.map { ($0.0, $0.1 as Any) }
            .mappable(as: type, to: object, keyPath: keyPath, context: context)
    }
    
    public func mappableArray<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[T]> {
        return self.map { ($0.0, $0.1 as Any) }
            .mappableArray(as: type, keyPath: keyPath, context: context)
    }
    
    public func mappableDictionary<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:T]> {
        return self.map { ($0.0, $0.1 as Any) }
            .mappableDictionary(as: type, keyPath: keyPath, context: context)
    }
    
    public func mappableDictionaryOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[String:[T]]> {
        return self.map { ($0.0, $0.1 as Any) }
            .mappableDictionaryOfArrays(as: type, keyPath: keyPath, context: context)
    }
    
    public func mappableArrayOfArrays<T: Mappable>(`as` type: T.Type? = nil, keyPath: String? = nil, context: MapContext? = nil) -> Observable<[[T]]> {
        return self.map { ($0.0, $0.1 as Any) }
            .mappableArrayOfArrays(as: type, keyPath: keyPath, context: context)
    }
}
