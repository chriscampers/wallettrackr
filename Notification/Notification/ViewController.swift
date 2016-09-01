

import UIKit
import GoogleMobileAds
struct Constants {
    //let b:beac = beac()
      static let _UUID:String! = beac().uuidCheck()
  
    
}

class ViewController: UIViewController, ESTBeaconManagerDelegate, GADBannerViewDelegate  {
    
    var _major:Int?
    var _minor:Int?
    let b:beac = beac()
    

    @IBOutlet weak var _banner: GADBannerView!
    //DisplayBeacons RSSI
    @IBOutlet weak var _RSSIDisplay: UILabel!
     let _userDefault = NSUserDefaults.standardUserDefaults()

    
    @IBAction func settingsPressed(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("settings") as! SettingsViewController
        self.presentViewController(resultViewController, animated: true, completion: nil)
        
    }
    let _test:String! = Constants._UUID
    
    @IBOutlet weak var _RSSICircle: KDCircularProgress!
    //Beacon Manager For Ranging
       let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: Constants._UUID!)!,
        identifier: "ranged region")
    //***********************************
   /* let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString:Constants._UUID!)!,
        identifier: "ranged region")*/
    //***********************************

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func loadBanner(){
        _banner.delegate = self
       // _banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        _banner.adUnitID = "ca-app-pub-8448074232552599/6177602062"
        _banner.rootViewController = self
        let req: GADRequest = GADRequest()
        _banner.loadRequest(req)
        _banner.frame = CGRectMake(0, view.bounds.height - _banner.frame.size.height, _banner.frame.size.width, _banner.frame.size.height)
        self.view.addSubview(_banner)
    }
    
    func uuidCheck() -> String{
         let uuid:String! = String(NSUserDefaults.standardUserDefaults().objectForKey("uuid")!)
        
        return uuid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //GET MAJOR AND MINOR NUMBERS FOR CROSS REFERENCING AGAINST RANGING BEACONS
        if (_userDefault.objectForKey("major") == nil){
            _major = 1;
        }
        else{
            _major = (_userDefault.objectForKey("major") as! Int?)!
        }

        
        if (_userDefault.objectForKey("minor") == nil){
            _minor = 1;
        }
        else{
            _minor = (_userDefault.objectForKey("minor") as! Int?)!
        }
        // Code for swipe Geausutre
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        //*******************************
        
        
        //Beacon Manager For Beacon Ranging
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        //************************
        loadBanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                
                print("Swiped right")
                
                //change view controllers
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("mapview") as! MapViewController
                self.presentViewController(resultViewController, animated: true, completion: nil)
                //self.showViewController(resultViewController, sender: self)
                
                //self.present(resultViewController, animated:true, completion:nil)
                
            default:
                break
            }
        }
    }
    func newAngle( rssi:Double) -> Double {
        
        var n:Double = (rssi+20);
        print(n)
        if(n > 50){
            n = n + 0
        }
        else if(n > -58) {
            n = n + (n * 0.25)
        }
        else if(n > -65){
            n = n + (n * 0.5)
        }
        
        else if( n > -100){
            n = n + n
        }
        let num:Double = Double((165+n)/165);
        
        let num1 = num*360;
        return Double(num1)
    }
    //Starts ranging when view appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    //Ends ranging when view disapears
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    //When beacons are picked up what to do?
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon],
                       inRegion region: CLBeaconRegion) {
        
        if (beacons.count > 1){
            for index in 0..<beacons.count {
                if (beacons[index].major == _major && beacons[index].minor == _minor){
                    let newAngleValue = newAngle(Double(beacons[index].rssi))
                    print(newAngleValue)
                    _RSSIDisplay.text = String((beacons[index].rssi+20) * -1)
                    _RSSICircle.animateToAngle(newAngleValue, duration: 0.0, completion: nil)
                }
            }
        }
        else{
            let nearestBeacon = beacons.first


        //_RSSIDisplay.text = String(String(nearestBeacon!.rssi*(-1)))
            if(nearestBeacon != nil){
                let newAngleValue = newAngle(Double(nearestBeacon!.rssi))
                print(newAngleValue)
                _RSSIDisplay.text = String((nearestBeacon!.rssi+20) * -1)
                _RSSICircle.animateToAngle(newAngleValue, duration: 0.0, completion: nil)
            }
            else{_RSSIDisplay.text = "Not In Range"}
        
        
       // print(nearestBeacon?.rssi)
        }
        
    }

}
