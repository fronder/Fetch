//
//  DeliveryDetailViewController.swift
//  TestHasan
//
//  Created by Hasan on 8/15/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit

class DeliveryDetailViewController: UIViewController {
  
  // MARK: Variables
  
  var viewModel: DeliveriesViewModel!
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = viewModel.title
    
    configureMapView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    viewModel.selectedDelivery = nil
  }
  
  
  // MARK: Initializers
  
  private func configureMapView() {
    self.view.addSubview(MapView(withFrame: self.view.bounds, object: viewModel.selectedDelivery))
  }
}
