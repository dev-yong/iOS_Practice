//
//  WeatherViewController.swift
//  SOPT_HomeWork3
//
//  Created by 이광용 on 2017. 11. 19..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let weatherState:[String: UIImage?] =
        ["SKY_A00": UIImage(named: "38"),
         "SKY_A01": UIImage(named: "01"),
         "SKY_A02": UIImage(named: "02"),
         "SKY_A03": UIImage(named: "03"),
         "SKY_A04": UIImage(named: "12"),
         "SKY_A05": UIImage(named: "13"),
         "SKY_A06": UIImage(named: "14"),
         "SKY_A07": UIImage(named: "18"),
         "SKY_A08": UIImage(named: "21"),
         "SKY_A09": UIImage(named: "32"),
         "SKY_A10": UIImage(named: "4"),
         "SKY_A11": UIImage(named: "29"),
         "SKY_A12": UIImage(named: "26"),
         "SKY_A13": UIImage(named: "27"),
         "SKY_A14": UIImage(named: "28")]
    let appKey = ["appKey" : "80595012-2268-3f50-8fb9-2e8f43fe9229"]
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        
        // Do any additional setup after loading the view.
    }
    
    
    func initViewController()
    {
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            if let location = locationManager.location {
                let parameter: [String: Any] =
                    ["version": 1,
                     "lat": "\(location.coordinate.latitude)",
                     "lon": "\(location.coordinate.longitude)"]
 
                let url = "http://apis.skplanetx.com/weather/current/minutely?version=1&lat=\(parameter["lat"]!)&lon=\(parameter["lon"]!)"
                Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: appKey).responseJSON(){
                    response in
                    switch response.result
                    {
                    case .success :
                        self.networkResultData(resultData: response.data!, code: "Weather")
                        break
                    case .failure :
                        print("Error")
                        break
                    }
                }
            }
        }
    }
    
}

extension WeatherViewController: NetworkCallBack{
    func networkResultData(resultData: Data, code: String) {
        let result = JSON(resultData)
        let minutely = JSON(result["weather"]["minutely"])[0]
        debugPrint(result)
        debugPrint(minutely)
        weatherImg.image = weatherState[minutely["sky"]["code"].string!] as? UIImage
        
        weatherLabel.text = "현재 기온 : \(minutely["temperature"]["tc"].string ?? "0") (\(minutely["temperature"]["tmin"].string ?? "0") ~ \(minutely["temperature"]["tmax"].string ?? "0") ), 오늘의 날씨 : \(minutely["sky"]["name"].string ?? "모름")"
        return
    }
    
    func networkFailed(msg: Any?) {
        return
    }
}

extension WeatherViewController
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print(location.coordinate)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            showLocationDisablePopUp()
        }
    }
    
    func showLocationDisablePopUp() {
        let alert = UIAlertController(title: "위치 정보 제공 동의", message: "동의하십니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "동의", style: .default , handler: {(UIAlertAction) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
