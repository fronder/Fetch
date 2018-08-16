//
//  UIViewControllerExtension.swift
//  TestHasan
//
//  Created by Hasan on 8/15/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  func showAlert(text: String) {
    self.showAlert(title: "Warning", text: text, cancelButtonTitle: "OK", otherButtonTitle: nibName, block: nil)
  }
  
  func showAlert(title: String?, text: String?, cancelButtonTitle: String?, otherButtonTitle: String?, block:(() -> ())?) {
    let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
    
    let action = UIAlertAction(title: cancelButtonTitle, style: .default) { (action) in
      alertController.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action)
    
    if let _ = otherButtonTitle {
      let action = UIAlertAction(title: otherButtonTitle, style: .default) { (action) in
        alertController.dismiss(animated: true, completion: nil)
        if block != nil {
          block!()
        }
      }
      
      alertController.addAction(action)
    }
    
    self.present(alertController, animated: true, completion: nil)
  }
  
}
