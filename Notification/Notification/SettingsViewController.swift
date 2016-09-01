//
//  SettingsViewController.swift
//  Wallet Trackr
//
//  Created by Christopher Campanelli on 2016-07-08.

//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

    let _userDefault = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _UUID: UITextField!
    @IBOutlet weak var _beaconMajor: UITextField!
    @IBOutlet weak var _beaconMinor: UITextField!
    @IBAction func saveButtonClick(sender: AnyObject) {
        
        if(NSUUID(UUIDString: _UUID.text!) == nil){
            let alertController = UIAlertController(title: "Error", message:
                "Invalid UUID Entered", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else{
        _userDefault.setObject(_UUID.text!, forKey: "uuid")
        _userDefault.setObject(Int(_beaconMajor.text!)!, forKey: "major")
        _userDefault.setObject(Int(_beaconMinor.text!)!, forKey: "minor")
        _userDefault.setObject(_userName.text!, forKey: "name")
        print(_userName.text)
        }
        //print(_userDefault.object(forKey: "name"))
        //self.performSegueWithIdentifier("GoToViewController", sender:self)
        //AppDelegate.application
        //_resetText.text = "Please Kill App in the Background for New Settings to Take Effect"
      //  _resetText.textColor = UIColor.red
    }
    
    
    @IBAction func backbutton(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("start") as! ViewController
        self.presentViewController(resultViewController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var _resetText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)

    }
}
