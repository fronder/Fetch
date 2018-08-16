//
//  DeliveryObject.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import RealmSwift

class DeliveryObject: Object {
  @objc dynamic private var comment: String?
  @objc dynamic var imageUrlString: String?
  @objc dynamic var location: Location?
  @objc dynamic var id: String!
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var textDescription: String {
    return "\(String(describing: comment!)) at \(String(describing: location!.address!))"
  }
  
  func setComment(comment: String!) {
    self.comment = comment
  }

}
