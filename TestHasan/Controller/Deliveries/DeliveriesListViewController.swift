//
//  DeliveriesListViewController.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import PKHUD

class DeliveriesListViewController: UIViewController {
  
  // MARK: Variables
  
  var tableView: UITableView!
  var viewModel: DeliveriesViewModel = DeliveriesViewModel()
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshDidClick))
    
    setupTableView()
    update()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.title = viewModel.title
  }
  
  
  // MARK: Initializers
  
  private func setupTableView() {
    tableView = UITableView(frame: self.view.bounds)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = viewModel.rowHeight
    self.view.addSubview(tableView)
    
    tableView.register(DeliveriesTableViewCell.self, forCellReuseIdentifier: DeliveriesTableViewCell.reuseIdentifier)
  }
  
  
  // MARK: Action
  
  @objc private func refreshDidClick() {
    fetch()
  }
  
  // MARK: Private
  
  private func update() {
    viewModel.fetchStoredDeliveries()
    if !viewModel.hasData {
      fetch()
    }
  }
  
  private func fetch() {
    PKHUD.sharedHUD.contentView = PKHUDProgressView(title: nil, subtitle: "Attempting to fetch data...")
    PKHUD.sharedHUD.show()
    
    self.viewModel.fetchDeliveries { (success) in
      if success {
        onMain {
          self.tableView.reloadData()
        }
      } else {
        self.showAlert(text: "Error occured, please try again")
      }
      
      PKHUD.sharedHUD.hide()
    }
  }
}


// MARK: UITableView Delegates

extension DeliveriesListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: DeliveriesTableViewCell.reuseIdentifier, for: indexPath) as? DeliveriesTableViewCell {
      
      let object = viewModel.items[indexPath.row]
      cell.bindData(object: object)
      
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DeliveryDetailViewController()
    viewModel.selectedDelivery = viewModel.items[indexPath.row]
    vc.viewModel = viewModel
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
