//
//  AppStart.swift
//  TestHasan
//
//  Created by Hasan on 8/15/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit

class AppStart {

  // MARK: Inastance Variables
  
  private let window: UIWindow
  private let navigationController: UINavigationController
  
  
  // MARK: Init
  
  init(window: UIWindow) {
    self.window = window
    
    self.navigationController = UINavigationController.init(rootViewController: DeliveriesListViewController())
    
    self.window.rootViewController = self.navigationController
    self.window.makeKeyAndVisible()
  }

}
