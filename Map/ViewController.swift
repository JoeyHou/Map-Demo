//
//  ViewController.swift
//  Map
//
//  Created by 候钊轶 on 2017/8/3.
//  Copyright © 2017年 Joey. All rights reserved.
//

import UIKit
import MapKit

struct VocationLocation{
    let name:String
    let latitude:Double
    let longitude:Double
}


class ViewController: UIViewController, MKMapViewDelegate {
    
    var vocationLocations = [VocationLocation]()
    //var currentLocation : VocationLocation?
    var codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())

    var currentIndex = 0

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func next(_ sender: Any) {
            print("Next is shown")
        
            //let index = vocationLocations.index { (vl) -> Bool in
            //    return vl.name == currentLocation?.name
            //}
            var nextLocation = vocationLocations[0]
            if currentIndex == vocationLocations.count-1{
                currentIndex = 0
                nextLocation = vocationLocations[0]
                navigationItem.title = vocationLocations[currentIndex].name
            }
                
            else {nextLocation = vocationLocations[currentIndex + 1]
                currentIndex+=1
            
                navigationItem.title = vocationLocations[currentIndex].name
            }
            
            
            //let nextLocation = vocationLocations[1]
        
            let coordinate = CLLocationCoordinate2DMake(nextLocation.latitude, nextLocation.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
    }
    
    @IBAction func back(_ sender: Any) {
        print("Previous one is shown")
        
        var previousLocation = vocationLocations[0]
        if currentIndex == 0{
            currentIndex = vocationLocations.count-1
            previousLocation = vocationLocations[vocationLocations.count-1]
            navigationItem.title = vocationLocations[currentIndex].name
            }
            
        else {previousLocation = vocationLocations[currentIndex - 1]
            currentIndex -= 1
            navigationItem.title = vocationLocations[currentIndex].name
            }
        
        
        //let nextLocation = vocationLocations[1]
        
        let coordinate = CLLocationCoordinate2DMake(previousLocation.latitude, previousLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    @IBAction func play(_ sender: Any) {
        
        // 定义需要计时的时间
        var timeCount = 60
        // 在global线程里创建一个时间源
        //codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(7))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            
            
            print("Next is shown")
            timeCount = timeCount - 1
            // 时间到了取消时间源
            if timeCount <= 0 {
                self.codeTimer.cancel()
            }
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                var nextLocation = self.vocationLocations[0]
                if self.currentIndex == self.vocationLocations.count-1{
                    self.currentIndex = 0
                    nextLocation = self.vocationLocations[0]
                    self.navigationItem.title = self.vocationLocations[self.currentIndex].name
                }
                    
                else {nextLocation = self.vocationLocations[self.currentIndex + 1]
                    self.currentIndex+=1
                    
                    self.navigationItem.title = self.vocationLocations[self.currentIndex].name
                }
                
                
                //let nextLocation = vocationLocations[1]
                
                let coordinate = CLLocationCoordinate2DMake(nextLocation.latitude, nextLocation.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)

                
            }
        })
        // 启动时间源
        codeTimer.resume()
        
    }
    
    @IBAction func stop(_ sender: Any) {
        codeTimer.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let hawaii = VocationLocation(name:"Hawaii", latitude: 21.3149, longitude: -157.8591)
        let tokyo = VocationLocation(name:"Tokyo", latitude: 35.71, longitude: 139.7309)
        let barcelona = VocationLocation(name:"Barcelona", latitude: 41.3846, longitude: 2.1792)
        let hongkong = VocationLocation(name:"Hongkong", latitude: 22.2816, longitude: 114.1765)
        let sandiego = VocationLocation(name:"San Diego", latitude: 32.7203, longitude: -117.1432)
        let miami = VocationLocation(name:"Miami", latitude: 25.8112, longitude: -80.1973)
        
        
        vocationLocations.append(hawaii)
        vocationLocations.append(tokyo)
        vocationLocations.append(barcelona)
        vocationLocations.append(hongkong)
        vocationLocations.append(sandiego)
        vocationLocations.append(miami)
        
        for vl in vocationLocations{
            print(vl.name)
            let annotation = MKPointAnnotation()
            annotation.title = vl.name
            annotation.coordinate = CLLocationCoordinate2DMake(vl.latitude, vl.longitude)
            mapView.addAnnotation(annotation)
        }
        
        let coordinate = CLLocationCoordinate2DMake(21.3149, -157.8591)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let customAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "id")
        customAnnotationView.image = #imageLiteral(resourceName: "pin")
        print("try to draw a pin")
        return customAnnotationView
    }
    
    
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print("isDrawn")
//        let customAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "id")
//        customAnnotationView.image = #imageLiteral(resourceName: "pin")
//        print("try to draw a pin")
//        return customAnnotationView
//    }
}
