//
//  DatabaseManager.swift
//  TestHasan
//
//  Created by Hasan on 8/15/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class DatabaseManager: NSObject {
  
  // MARK: Variables
  
  private var aKey = 0
  
  static let sharedInstance = DatabaseManager()
  let realm = try! Realm()
  
  
  // MARK: Public
  
  func addDeliveries(data: [JSON])  {
    for json in data {
      var loc = json["location"]
      
      let location = Location()
      location.lat = Double(truncating: loc["lat"].numberValue)
      location.long = Double(truncating: loc["lng"].numberValue)
      location.address = loc["address"].string
      
      let object = DeliveryObject()
      object.setComment(comment: json["description"].stringValue)
      object.imageUrlString = json["imageUrl"].stringValue
      object.location = location
      object.id = primaryKey()
      saveObject(object: object)
    }
  }
  
  func getDeliveries() -> Results<DeliveryObject> {
    return realm.objects(DeliveryObject.self)
  }
  
  
  // MARK: Private
  
  private func primaryKey() -> String {
    aKey = aKey+1
    return "\(aKey)"
  }
  
  // MARK: Realm operations
  
  private func saveObject(object: Object) {
    try! realm.write {
      realm.add(object, update: true)
    }
  }
  
  func update(block:() -> ()) {
    try! realm.write {
      block()
    }
  }
}
