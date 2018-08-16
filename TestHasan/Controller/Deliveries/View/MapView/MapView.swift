//
//  MapView.swift
//  TestHasan
//
//  Created by Hasan on 8/15/18.
//  Copyright © 2018 Hasan. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import SDWebImage

class MapView: MKMapView, MKMapViewDelegate {

  // MARK: Variables
  
  var object: DeliveryObject!
  
  // MARK: Life Cycle
  
  convenience init(withFrame: CGRect, object: DeliveryObject) {
    self.init(frame: withFrame)
    self.object = object
    
    configure()
    setupDescriptionView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 
  // MARK: Private
  
  private func configure() {
    addAnnotations(location: self.object.location!)
  }
  
  private func setupDescriptionView() {
    let view = UIView()
    self.addSubview(view)
    view.backgroundColor = UIColor.white
    
    let imageView = UIImageView()
    view.addSubview(imageView)
    if let urlString = object.imageUrlString {
      imageView.sd_setImage(with: URL(string: urlString), completed: nil)
    }
    
    let descriptionLabel = UILabel()
    view.addSubview(descriptionLabel)
    descriptionLabel.text = object.textDescription
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.numberOfLines = 0
    
    view.snp.makeConstraints { (make) in
      make.left.equalTo(0)
      make.right.equalTo(0)
      make.height.equalTo(90)
      make.bottom.equalTo(0)
    }
    
    imageView.snp.makeConstraints { (make) in
      make.top.equalTo(8)
      make.left.equalTo(8)
      make.width.equalTo(view.snp.height).offset(-16)
      make.bottom.equalTo(-8)
    }
    
    descriptionLabel.snp.makeConstraints { (make) in
      make.top.equalTo(8)
      make.left.equalTo(imageView.snp.right).offset(8)
      make.right.equalTo(-8)
      make.bottom.equalTo(-8)
    }
  }
  
  private func addAnnotations(location: Location) {
    let coordinates = CLLocation(latitude: location.lat, longitude: location.long)
    let CLLCoordType = CLLocationCoordinate2D(latitude: coordinates.coordinate.latitude,
                                              longitude: coordinates.coordinate.longitude)
    let annotation = MKPointAnnotation()
    annotation.coordinate = CLLCoordType
    self.addAnnotation(annotation)
    
    self.showAnnotations([annotation], animated: true)
  }
}
