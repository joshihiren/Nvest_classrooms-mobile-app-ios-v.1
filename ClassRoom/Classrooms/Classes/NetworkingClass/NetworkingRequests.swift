//
//  NetworkingRequests.swift
//  Lead
//
//  Created by Hiren Joshi on 03/01/20.
//  Copyright © 2020 Hiren Joshi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import SwiftyJSON

enum APIError: Error {
    case InternetConnection
    case invalidInput
    case badResposne
    case invalidURL
    
    func toNSError() -> NSError {
        let domain = "Domain url"
        switch self {
        case .InternetConnection:
            return NSError(domain: domain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Internet connection not available please, check Internet and try agian!"])
        case .invalidURL:
            return NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Input should be a valid URL"])
        case .invalidInput:
            return NSError(domain: domain, code: -2, userInfo: [NSLocalizedDescriptionKey: "Input should be a valid number"])
        case .badResposne:
            return NSError(domain: domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Bad response"])
        }
    }
}

@objc public class NetworkingRequests: NSObject {
    
    static let shared = NetworkingRequests()
    
    var successcomplitionHandler: ((_ data: Any)->Void)?
    var onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?
    var rechability: Reachability!
    
    @objc class var swiftSharedInstance: NetworkingRequests {
        struct Singleton {
            static let instance = NetworkingRequests()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    @objc class func sharedInstance() -> NetworkingRequests {
        return NetworkingRequests.swiftSharedInstance
    }
    
    private override init() {
        self.rechability = Reachability.init(hostname: "www.google.com")
        self.rechability.startNotifier()
    }
    
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func getCurrentViewController() -> UIViewController? {
        if #available(iOS 13, *) {
            let window = UIApplication.shared.windows
            if let rootController = window[0].rootViewController {
                var currentController: UIViewController! = rootController
                while( currentController.presentedViewController != nil ) {
                    currentController = currentController.presentedViewController
                }
                return currentController
            }
            return nil
        } else {
            
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                var currentController: UIViewController! = rootController
                while( currentController.presentedViewController != nil ) {
                    currentController = currentController.presentedViewController
                }
                return currentController
            }
            return nil
        }
    }
    
    class func displayError(_ error: NSError?) {
        if let e = error {
            let alertController = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // do nothing...
            }
            alertController.addAction(okAction)
            self.getCurrentViewController()!.present(alertController, animated: true, completion: nil)
        }
    }
    
}

//MARK:- JsonCOnverter
extension NetworkingRequests {
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

//MARK:- Request Methods
extension NetworkingRequests {
    
    func NetworkPostrequestJSON(_ key: PlistKey, Parameters: [String: Any]? = nil, Headers: [String: String]? = nil, onSuccess: ((_ data: [String: Any], _ status: Bool)->Void)?, onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?) {
        
        if self.rechability.isReachable() || NetworkingRequests.isInternetAvailable() {
            let url = Environments.shared.GetDomainURL(key)
            if url.count != 0 {
                
                RxAlamofire.requestJSON(.post, url, parameters: Parameters, encoding: JSONEncoding.default, headers: Headers).observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, results) = arg0
                        if responseobject.statusCode == 200 {
                            guard let body = results as? [String: Any] else {
                                onError!("mapping issue", responseobject.statusCode)
                                return
                            }
                            let status = body["status"] as AnyObject
                            let statuscode: Bool
                            switch status {
                            case is String:
                                print("\(status) is a string!")
                                if (status as! String) == "1" {
                                    statuscode = true
                                }
                                else {
                                    statuscode = false
                                }
                            case is Int:
                                print("\(status) is an integer!")
                                if (status as! Int) == 1 {
                                    statuscode = true
                                }
                                else {
                                    statuscode = false
                                }
                            case is Bool:
                                statuscode = status as! Bool
                                
                            default:
                                print("I don't know this value!")
                                statuscode = status as! Bool
                            }
                            print(body)
                            AppUtillity.shared.NetworkIndicator(status: false)
                            onSuccess!(body, statuscode)
                        }
                        else {
                            guard let body = results as? [String: Any] else {
                                onError!("mapping issue", responseobject.statusCode)
                                return
                            }
                            AppUtillity.shared.NetworkIndicator(status: false)
                            onError!("Server side error occur", responseobject.statusCode)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        onError!(error.localizedDescription, 401)
                    }, onCompleted: {
                        
                    }) {
                        
                }
            }
            else {
                AppUtillity.shared.NetworkIndicator(status: false)
                onError!(APIError.invalidURL.toNSError().localizedDescription, 401)
            }
        }
        else {
            AppUtillity.shared.NetworkIndicator(status: false)
            onError!(APIError.InternetConnection.toNSError().localizedDescription, 1000)
        }
        
    }
    
    func NetworkPostrequestJSONOtherWay(_ key: PlistKey, Parameters: [String: Any]? = nil, Headers: [String: String]? = nil, onSuccess: ((_ data: [String: Any], _ status: Bool)->Void)?, onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?) {
        
        if self.rechability.isReachable() {
            let url = Environments.shared.GetDomainURL(key)
            if url.count != 0 {
                RxAlamofire.requestJSON(.post, url, parameters: Parameters, encoding: JSONEncoding.default, headers: Headers).debug().flatMap { (json , responseobject) -> Observable<[String: Any]> in
                    guard let body = responseobject as? [String: Any]
                        else {
                            return .error(APIError.badResposne.toNSError())
                    }
                    let status = body["status"] as AnyObject
                    let statuscode: Bool
                    switch status {
                    case is String:
                        print("\(status) is a string!")
                        if (status as! String) == "1" {
                            statuscode = true
                        }
                        else {
                            statuscode = false
                        }
                    case is Int:
                        print("\(status) is an integer!")
                        if (status as! Int) == 1 {
                            statuscode = true
                        }
                        else {
                            statuscode = false
                        }
                    case is Bool:
                        statuscode = status as! Bool
                        
                    default:
                        print("I don't know this value!")
                        statuscode = status as! Bool
                    }
                    AppUtillity.shared.NetworkIndicator(status: false)
                    onSuccess!(body, statuscode)
                    return .just(body)
                }.subscribe(onNext: { (body) in
                    print(body)
                }, onError: { e in
                    NetworkingRequests.displayError(e as NSError)
                })
                    .disposed(by: DisposeBag())
            }
            else {
                AppUtillity.shared.NetworkIndicator(status: false)
                onError!(APIError.invalidURL.toNSError().localizedDescription, 401)
            }
        }
        else {
            AppUtillity.shared.NetworkIndicator(status: false)
            onError!(APIError.InternetConnection.toNSError().localizedDescription, 1000)
        }
        
    }
    
    func NetworkPostrequestSTRING(_ key: PlistKey, Parameters: [String: Any]? = nil, Headers: [String: String]? = nil, onSuccess: ((_ data: [String: Any], _ status: Bool)->Void)?, onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?) {
        
        if self.rechability.isReachable() {
            let url = Environments.shared.GetDomainURL(key)
            if url.count != 0 {
                RxAlamofire.requestString(.post, url, parameters: Parameters, encoding: JSONEncoding.default, headers: Headers)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (arg0) in
                        let (responseobject, message) = arg0
                        let data = self.convertToDictionary(text: message)
                        guard let body = data else {
                            onError!(message , responseobject.statusCode)
                            return
                        }
                        if responseobject.statusCode == 200 {
                            let status = body["status"] as AnyObject
                            let statuscode: Bool
                            switch status {
                            case is String:
                                print("\(status) is a string!")
                                if (status as! String) == "1" {
                                    statuscode = true
                                }
                                else {
                                    statuscode = false
                                }
                            case is Int:
                                print("\(status) is an integer!")
                                if (status as! Int) == 1 {
                                    statuscode = true
                                }
                                else {
                                    statuscode = false
                                }
                            case is Bool:
                                statuscode = status as! Bool
                                
                            default:
                                print("I don't know this value!")
                                statuscode = status as! Bool
                            }
                            AppUtillity.shared.NetworkIndicator(status: false)
                            onSuccess!(body, statuscode)
                        }
                        else {
                            AppUtillity.shared.NetworkIndicator(status: false)
                        }
                    }, onError: { (error) in
                        AppUtillity.shared.NetworkIndicator(status: false)
                        onError!(error.localizedDescription, 401)
                    }, onCompleted: {
                        
                    }) {
                        
                }
            }
            else {
                AppUtillity.shared.NetworkIndicator(status: false)
                onError!(APIError.invalidURL.toNSError().localizedDescription, 401)
            }
        }
        else {
            AppUtillity.shared.NetworkIndicator(status: false)
            onError!(APIError.InternetConnection.toNSError().localizedDescription, 1000)
        }
        
    }
    
    func NetworkGetRequest(_ key: PlistKey, Parameters: [String: Any]? = nil, Headers: [String: String]? = nil, onSuccess: ((_ data: [String: Any], _ status: Bool)->Void)?, onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?) {
        
        if self.rechability.isReachable() {
            let url = Environments.shared.GetDomainURL(key)
            if url.count != 0 {
                RxAlamofire.requestJSON(.get, url)
                    .debug()
                    .flatMap { (arg0) -> Observable<[String: Any]> in
                        let (responseobject, results) = arg0
                        print(responseobject)
                        print(results)
                        //                let data = self.convertToDictionary(text: results)
                        guard let body = results as? [String: Any]
                            else {
                                onError!("get methods issue" , responseobject.statusCode)
                                return .error(APIError.badResposne.toNSError())
                        }
                        let status = body["status"] as AnyObject
                        let statuscode: Bool
                        switch status {
                        case is String:
                            print("\(status) is a string!")
                            if (status as! String) == "1" {
                                statuscode = true
                            }
                            else {
                                statuscode = false
                            }
                        case is Int:
                            print("\(status) is an integer!")
                            if (status as! Int) == 1 {
                                statuscode = true
                            }
                            else {
                                statuscode = false
                            }
                        case is Bool:
                            statuscode = status as! Bool
                            
                        default:
                            print("I don't know this value!")
                            statuscode = status as! Bool
                        }
                        AppUtillity.shared.NetworkIndicator(status: false)
                        onSuccess!(body, statuscode)
                        return .just(body)
                }
                .subscribe(onNext: { (body) in
                    AppUtillity.shared.NetworkIndicator(status: false)
                    onSuccess!(body, true)
                }, onError: { e in
                    NetworkingRequests.displayError(e as NSError)
                })
                    .disposed(by: DisposeBag())
            }
            else {
                AppUtillity.shared.NetworkIndicator(status: false)
                onError!(APIError.invalidURL.toNSError().localizedDescription, 401)
            }
        }
        else {
            AppUtillity.shared.NetworkIndicator(status: false)
            onError!(APIError.InternetConnection.toNSError().localizedDescription, 1000)
        }
        
    }
    
    func requestsGETURL(_ key: PlistKey, Parameters: [String: Any]? = nil, Headers: [String: String]? = nil, onSuccess: ((_ data: Any)->Void)?, onError: ((_ msg: String, _ ErrCode: NSInteger?)->Void)?) {
        
        if self.rechability.isReachable() {
            let strURL = Environments.shared.GetDomainURL(key)
            if strURL.count != 0 {
                //            Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
                //                print(responseObject)
                //                if responseObject.result.isSuccess {
                //                    onSuccess!(responseObject)
                //                }
                //                if responseObject.result.isFailure {
                //                    let error : Error = responseObject.result.error!
                //                    onError!(error.localizedDescription, 401)
                //                }
                //            }
                Alamofire.request(strURL, method: .get, parameters: Parameters, encoding: URLEncoding.default, headers: Headers).responseJSON { (responseObject) in
                    if((responseObject.result.value) != nil) {
                        let swiftyJsonVar = JSON(responseObject.result.value!)
                        print(swiftyJsonVar)
                        if responseObject.result.isSuccess {
                            AppUtillity.shared.NetworkIndicator(status: false)
                            onSuccess!(responseObject)
                        }
                        if responseObject.result.isFailure {
                            let error : Error = responseObject.result.error!
                            AppUtillity.shared.NetworkIndicator(status: false)
                            onError!(error.localizedDescription, 401)
                        }
                    }
                }
            }
            else {
                AppUtillity.shared.NetworkIndicator(status: false)
                onError!(APIError.invalidURL.toNSError().localizedDescription, 401)
            }
        }
        else {
            AppUtillity.shared.NetworkIndicator(status: false)
            onError!(APIError.InternetConnection.toNSError().localizedDescription, 1000)
        }
        
    }
    
}

//    func exampleUsages() {
//
//        let stringURL = ""
//        // NSURLSession simple and fast
//        let session = URLSession.shared
//        _ = session.rx
//            .json(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        _ = session
//            .rx.json(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        _ = session
//            .rx.data(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        //  With Alamofire engine
//
//        _ = json(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//
//        _ = request(.get, stringURL)
//            .flatMap { request in
//                return request.validate(statusCode: 200..<300)
//                    .validate(contentType: ["text/json"])
//                    .rx.json()
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//        // progress
//        _ = request(.get, stringURL)
//            .flatMap {
//                $0
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/json"])
//                    .rx.progress()
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//        // just fire upload and display progress
//
//
//        _ = upload(Data(), urlRequest: try! RxAlamofire.urlRequest(.get, stringURL))
//            .flatMap {
//                $0
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/json"])
//                    .rx.progress()
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//        // progress and final result
//        // uploading files with progress showing is processing intensive operation anyway, so
//        // this doesn't add much overhead
//        _ = request(.get, stringURL)
//            .flatMap { request -> Observable<(Data?, RxProgress)> in
//                let validatedRequest = request
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/json"])
//
//                let dataPart = validatedRequest
//                    .rx.data()
//                    .map { d -> Data? in d }
//                    .startWith(nil as Data?)
//                let progressPart = validatedRequest.rx.progress()
//                return Observable.combineLatest(dataPart, progressPart) { ($0, $1) }
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//
//        //  Alamofire manager
//        // same methods with with any alamofire manager
//
//        let manager = SessionManager.default
//
//        // simple case
//        _ = manager.rx.json(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//
//        // NSURLHTTPResponse + JSON
//        _ = manager.rx.responseJSON(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        // NSURLHTTPResponse + String
//        _ = manager.rx.responseString(.get, stringURL)
//            .observeOn(MainScheduler.instance)
//            .subscribe { print($0) }
//
//        // NSURLHTTPResponse + Validation + String
//        _ = manager.rx.request(.get, stringURL)
//            .flatMap {
//                $0
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/json"])
//                    .rx.string()
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//        // NSURLHTTPResponse + Validation + NSURLHTTPResponse + String
//        _ = manager.rx.request(.get, stringURL)
//            .flatMap {
//                $0
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/json"])
//                    .rx.responseString()
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//
//        // NSURLHTTPResponse + Validation + NSURLHTTPResponse + String + Progress
//        _ = manager.rx.request(.get, stringURL)
//            .flatMap { request -> Observable<(String?, RxProgress)> in
//                let validatedRequest = request
//                    .validate(statusCode: 200 ..< 300)
//                    .validate(contentType: ["text/something"])
//
//                let stringPart = validatedRequest
//                    .rx.string()
//                    .map { d -> String? in d }
//                    .startWith(nil as String?)
//                let progressPart = validatedRequest.rx.progress()
//                return Observable.combineLatest(stringPart, progressPart) { ($0, $1) }
//        }
//        .observeOn(MainScheduler.instance)
//        .subscribe { print($0) }
//    }
