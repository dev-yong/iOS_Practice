//
//  ViewController.swift
//  DaumMapExample
//
//  Created by 이광용 on 2018. 1. 31..
//  Copyright © 2018년 이광용. All rights reserved.
//


/*
 1. Add Frameworks
 2. [info.plist] - 'KAKAO_APP_KEY'(String)
 3. [info.plist] - 'App Transport Security Settings'
 4. [info.plist] - 'Privacy - Location When In Use Usage Description'
 5. DaumMapBridgingHeader
 6. MTMapViewDelegate, CLLocationManagerDelegate
*/

import UIKit
import CoreLocation
enum POIType: Int {
    case dog = 0
    case home = 1
}
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
            let markerItem = MTMapLocationMarkerItem()
            markerItem.fillColor = UIColor.green.withAlphaComponent(0.1)
            markerItem.strokeColor = UIColor.green.withAlphaComponent(0.3)
            markerItem.radius = 30
            mapView.updateCurrentLocationMarker(markerItem)
            self.mapFillView.insertSubview(mapView, at: 0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let coordinate = locationManager.location?.coordinate {
            self.mapView.setMapCenter(MTMapPoint(geoCoord: .init(latitude: coordinate.latitude, longitude: coordinate.longitude)) , animated: true)
        }
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        currentLocation = location
    }
    
    func removePOIFromTag(type: POIType) {
        for item in self.mapView.poiItems as! [MTMapPOIItem] {
            if item.tag == type.rawValue {
                self.mapView.remove(item)
            }
        }
    }
    
    func poiItem(name: String, location: MTMapPoint, type: POIType) -> MTMapPOIItem {
        let poiItem = MTMapPOIItem()
        poiItem.itemName = name
        poiItem.markerType = .customImage
        poiItem.mapPoint = location
        poiItem.showAnimationType = .springFromGround
        poiItem.showDisclosureButtonOnCalloutBalloon = false
        removePOIFromTag(type: type)
        switch type {
        case .dog:
            poiItem.tag = POIType.dog.rawValue
            poiItem.customImage = getPinImage(topImage: #imageLiteral(resourceName: "sitOn"))
            poiItem.customImageAnchorPointOffset = .init(offsetX: Int32(poiItem.customImage.size.width / 2) , offsetY: 0)
        case .home:
            poiItem.tag = POIType.home.rawValue
            poiItem.customImage = getImage(image: #imageLiteral(resourceName: "sitOn"))
            poiItem.customImageAnchorPointOffset = .init(offsetX: Int32(poiItem.customImage.size.width / 2),
                                                         offsetY: Int32(poiItem.customImage.size.height / 2))
            break
        }
        
        return poiItem
    }
    
    
    @IBAction func moveToCurrent(_ sender: UIButton) {
        self.mapView.setMapCenter(currentLocation, animated: true)
    }
    
    var bool = false
    func mapView(_ mapView: MTMapView!, longPressOn mapPoint: MTMapPoint!) {
        if bool {
            self.mapView.add(poiItem(name: "집", location: mapPoint, type: .home))
            bool = false
        }
        else {
            self.mapView.add(poiItem(name: "복순이", location: mapPoint, type: .dog))
            bool = true
        }
    }
    
    func getImage(image: UIImage) -> UIImage {
        let size = CGSize(width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContext(size)
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image.draw(in: areaSize)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
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


