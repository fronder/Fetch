//
//  DeliveriesService.swift
//  TestHasan
//
//  Created by Hasan on 8/14/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Response {
  var success: Bool = false
  var localizedDescription: String?
  var json: JSON?
}

protocol DeliveriesServiceProtocol: class {
  static func fetchDeliveries(block: @escaping (Response)->())
}

class DeliveriesService: DeliveriesServiceProtocol {
  
  static func fetchDeliveries(block: @escaping (Response) -> ()) {
    RequestManager.sharedInstance.requestGetDeliveries { (json, error) in
      guard let json = json else {
        let response = Response(success: false, localizedDescription: error?.localizedDescription, json: nil)
        block(response)
        return
      }
      
      let response = Response(success: true, localizedDescription: nil, json: json)
      block(response)
    }
  }
  
  
}
