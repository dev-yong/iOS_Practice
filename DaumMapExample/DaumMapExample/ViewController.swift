//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이광용 on 2018. 1. 31..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, MTMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapFillView: UIView!
    lazy var mapView: MTMapView = MTMapView(frame:
        CGRect(x: 0, y: 0, width: self.mapFillView.frame.size.width, height: self.mapFillView.frame.size.height))
    let locationManager = CLLocationManager()
    var currentLocation: MTMapPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            mapView.delegate = self
            mapView.baseMapType = .standard
            mapView.setZoomLevel(1, animated: true)
            mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
            //mapView.updateCurrentLocationMarker(MTMapLocationMarkerItem!)
            let markerItem = MTMapLocationMarkerItem()
            markerItem.fillColor = UIColor.green.withAlphaComponent(0.1)
            markerItem.strokeColor = UIColor.green.withAlphaComponent(0.3)
            markerItem.radius = 30
            mapView.updateCurrentLocationMarker(markerItem)
            self.mapFillView.insertSubview(mapView, at: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mapView.setMapCenter(currentLocation, animated: true)
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        self.mapView.removeAllPOIItems()
        self.mapView.add(poiItem(name: "복순이", location: location))
        //mapView.setMapCenter(location, animated: true)
        currentLocation = location
    }
    
    func poiItem(name: String, location: MTMapPoint) -> MTMapPOIItem {
        let poiItem = MTMapPOIItem()
        poiItem.itemName = name
        poiItem.markerType = .customImage
        poiItem.customImage = getPinImage(topImage: #imageLiteral(resourceName: "sitOn"))
        poiItem.mapPoint = location
        poiItem.showAnimationType = .springFromGround
        
        
        poiItem.customImageAnchorPointOffset = .init(offsetX: Int32(( #imageLiteral(resourceName: "locationG").size.width * 2 ) / 2) , offsetY: 0)
        return poiItem
    }
    
    
    @IBAction func moveToCurrent(_ sender: UIButton) {
        self.mapView.setMapCenter(currentLocation, animated: true)
    }
    
    
    
    func getPinImage(topImage: UIImage) -> UIImage {
        let image:UIImage = #imageLiteral(resourceName: "locationG")
        let size = CGSize(width: image.size.width * 2, height: image.size.height * 2)
        UIGraphicsBeginImageContext(size)
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image.draw(in: areaSize)
        
        let width = size.width * 0.9
        topImage.draw(in: CGRect(x: (size.width - width) / 2, y: (size.width - width) / 2
            , width: width, height: width)
            , blendMode: CGBlendMode.normal, alpha: 1)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    

}

