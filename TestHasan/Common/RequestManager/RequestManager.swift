//
//  RequestManager.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

fileprivate let deliveries = "/deliveries"

class RequestManager: NSObject {
  
  fileprivate static let baseURLString = "http://localhost:8080"
  
  //MARK: Singleton
  
  fileprivate let defaultManager: Alamofire.SessionManager = {
    let serverTrustPolicies: [String: ServerTrustPolicy] = [baseURLString: ServerTrustPolicy.pinCertificates(
      certificates: ServerTrustPolicy.certificates(in: Bundle.main),
      validateCertificateChain: true,
      validateHost: true
      ),
                                                            "insecure.expired-apis.com": .disableEvaluation
    ]
    
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    
    return Alamofire.SessionManager(
      configuration: configuration,
      serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
  }()
  
  static let sharedInstance = RequestManager()
  
}


//MARK: REQUEST API's

extension RequestManager {
  
  public func requestGetDeliveries(completion:@escaping (JSON?, NSError?) -> ()) {
    GET(endpoint: deliveries, parameters: nil, completion: completion)
  }
}


//MARK: Request Helpers

extension RequestManager {
  
  fileprivate func GET(endpoint: String, parameters: [String : AnyObject]?, completion: @escaping (JSON?, NSError?) -> ()) {
    defaultManager.request(RequestManager.baseURLString+endpoint, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
      .responseJSON { response in
        
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          print("JSON: \(json)")
          completion(json, nil)
        case .failure(let error):
          print(error)
          completion(nil, error as NSError)
        }
    }
  }

}
