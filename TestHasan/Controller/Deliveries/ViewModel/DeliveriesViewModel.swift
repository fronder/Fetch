//
//  DeliveriesViewModel.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit

class DeliveriesViewModel: NSObject {

  // MARK: Variables
  
  var items: [DeliveryObject] = []
  let rowHeight: CGFloat = 70
  var errorDescription: String?
  var selectedDelivery: DeliveryObject!
  var title: String {
    if (selectedDelivery != nil) {
      return "Delivery details"
    }
    return "Delivery list"
  }
  var hasData: Bool {
    if items.count > 0 {
      return true
    }
    return false
  }
  
  
  // MARK: Public
  
  public func fetchDeliveries(completion: @escaping (Bool)->()) {
    DeliveriesService.fetchDeliveries { (response) in
      if response.success {
        guard let data = response.json?.array else {
          self.errorDescription = response.localizedDescription
          completion(false)
          return
        }
  
        DatabaseManager.sharedInstance.addDeliveries(data: data)
        
        self.fetchStoredDeliveries()
        
        completion(true)
      } else {
        completion(false)
      }
    }
  }
  
  public func fetchStoredDeliveries() {
    let list = DatabaseManager.sharedInstance.getDeliveries()
    if list.count > 0 {
      self.items.removeAll()
      self.items.append(contentsOf: list)
    }
  }
  
  public func count() -> Int {
    return self.items.count
  }
}
