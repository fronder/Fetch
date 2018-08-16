//
//  Location.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import RealmSwift

class Location: Object {
  @objc dynamic var lat: Double = 0.0
  @objc dynamic var long: Double = 0.0
  @objc dynamic var address: String?
}
