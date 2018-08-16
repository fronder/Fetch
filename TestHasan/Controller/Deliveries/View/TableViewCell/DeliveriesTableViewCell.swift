//
//  DeliveriesTableViewCell.swift
//  TestHasan
//
//  Created by Hasan on 8/13/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

protocol CellReuseIdentifierabel {
  static var reuseIdentifier: String { get }
}

class DeliveriesTableViewCell: UITableViewCell {
  
  // MARK: Variables
  
  var itemImageView = UIImageView()
  var itemDescriptionLabel = UILabel()
  
  
  static var reuseIdentifier: String {
    return "\(self)"
  }

  // MARK: Life Cycle
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    itemImageView.snp.makeConstraints { (make) in
      make.top.equalTo(8)
      make.left.equalTo(8)
      make.width.equalTo(self.contentView.frame.height)
      make.bottom.equalTo(-8)
    }
    
    itemDescriptionLabel.snp.makeConstraints { (make) in
      make.top.equalTo(8)
      make.left.equalTo(itemImageView.snp.right).offset(8)
      make.right.equalTo(-8)
      make.bottom.equalTo(-8)
    }
  }

  
  // MARK: Helper
  
  func configure() {    
    itemDescriptionLabel.lineBreakMode = .byWordWrapping
    itemDescriptionLabel.numberOfLines = 0
    
    self.contentView.addSubview(itemImageView)
    self.contentView.addSubview(itemDescriptionLabel)
  }
  
  func bindData(object: DeliveryObject) {
    if let urlString = object.imageUrlString {
      itemImageView.sd_setImage(with: URL(string: urlString), completed: nil)
    }
    itemDescriptionLabel.text = object.textDescription
  }
}
