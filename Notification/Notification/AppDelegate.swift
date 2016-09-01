

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?

    let beaconNotificationsManager = BeaconNotificationsManager()
     let _userDefault = NSUserDefaults.standardUserDefaults()
    var _name:String?
    var _major:Int?
    var _minor:Int?
    var _UUID:String?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // You can get them by adding your app on https://cloud.estimote.com/#/apps
        ESTConfig.setupAppID("campanellichris-gmail-com--dis", andAppToken: "e50c48c8bfb6b10eab12106fcfbe388a")
        
        if (_userDefault.objectForKey("name") == nil){
            _name = "Please Set Name"
        }
        else{
            _name = (_userDefault.objectForKey("name")as! String?)!
        }
        if (_userDefault.objectForKey("major") == nil){
            _major = 1;
        }
        else{
            _major = (_userDefault.objectForKey("major") as! Int?)!
        }
        if (_userDefault.objectForKey("uuid") == nil){
            _userDefault.setObject("6D63C38A-44B9-11E6-BEB8-9E71128CAE75", forKey: "uuid")
            _UUID = "6D63C38A-44B9-11E6-BEB8-9E71128CAE77";
        }
        else{
            _UUID = (_userDefault.objectForKey("uuid") as! String?)!
        }

        if (_userDefault.objectForKey("minor") == nil){
            _minor = 1;
        }
        else{
            _minor = (_userDefault.objectForKey("minor") as! Int?)!
        }
        // let major = _userDefault.objectForKey("major"):(Int)
        self.beaconNotificationsManager.enableNotificationsForBeaconID(
            
            BeaconID(UUIDString: _UUID!, major: UInt16(_major!), minor: UInt16(_minor!)),
            enterMessage: _name! + " You Are In Range of wallet",
            exitMessage: _name! + " You Left Your Wallet Behind"
        )


        // NOTE: "exit" event has a built-in delay of 30 seconds, to make sure that the user has really exited the beacon's range. The delay is imposed by iOS and is non-adjustable.

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
