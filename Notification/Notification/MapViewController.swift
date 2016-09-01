//
//  MapViewController.swift
//  Wallet Trackr
//
//  Created by Christopher Campanelli on 2016-07-10.

//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate{
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

  //  @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var mapView: MKMapView!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    @IBAction func backButtonClick(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("start") as! ViewController
        self.presentViewController(resultViewController, animated: true, completion: nil)
        //self.present(resultViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self;
        let _userDefault = NSUserDefaults.standardUserDefaults()
        if (_userDefault.objectForKey("lat") == nil || _userDefault.objectForKey("long") == nil){
            latitude = 43.646710
            longitude = -79.694240
        }
        else{
            latitude = (_userDefault.objectForKey("lat") as! CLLocationDegrees?)!
            longitude = (_userDefault.objectForKey("long") as! CLLocationDegrees?)!
        }

        
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        
        let homeSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let homeLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(homeLocation, homeSpan)
        
        self.mapView.setRegion(theRegion, animated: false)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = homeLocation
        annotation.title = "wallet"
        //annotation.title = _userDefault.objectForKey("time")! as? String
        
        
        self.mapView.addAnnotation(annotation)
        let yourAnnotationAtIndex = 0
        mapView.selectAnnotation(mapView.annotations[yourAnnotationAtIndex], animated: true)
        
        /*
        // Do any additional setup after loading the view, typically from a nib.
       // let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FirstViewController.handleSwipes(_:)))
       // let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(FirstViewController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        */
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func handleSwipes(sender:UISwipeGestureRecognizer){
        let selectedIndex: Int = self.tabBarController!.selectedIndex
        if(sender.direction == .Right){
            self.tabBarController!.selectedIndex = selectedIndex - 1
        }
        else if(sender.direction == .Left){
            self.tabBarController!.selectedIndex = selectedIndex + 1
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
