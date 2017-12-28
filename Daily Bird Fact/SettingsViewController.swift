//
//  SettingsViewController.swift
//  Daily Bird Facts
//
//  Created by Alex Philpott on 6/9/16.
//  Copyright © 2016 Phillpot and Casciano. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchButton: UIButton!
    
    var mode = UserDefaults.standard.integer(forKey: "MyKey")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        /*if mode == 1 {
            switchButton.setTitle("Switch to 'Share on Twitter'!", forState: .Normal)
        }
        else if mode == 2 {
            switchButton.setTitle("Switch to 'Share on Facebook'!", forState: .Normal)
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("mode is", mode)
        // Do any additional setup after loading the view.
    }

    @IBAction func submitFact(_ sender: UIButton) {
        let link1 = "http://www.aphilpott.com/submit-your-own-bird-fact.html"
        UIApplication.shared.openURL(URL(string: link1)!)
    }
    
    @IBAction func visitSite(_ sender: UIButton) {
        let link2 = "http://www.aphilpott.com"
        UIApplication.shared.openURL(URL(string: link2)!)
    }

    @IBAction func contactUs(_ sender: UIButton) {
        let link3 = "http://www.aphilpott.com/contact.html"
       UIApplication.shared.openURL(URL(string: link3)!)
    }
    
    /*@IBAction func switchShare(sender: UIButton) {
        if mode == 1 {
            print("mode is 2")
            mode = 2
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(mode, forKey: "MyKey")
            defaults.synchronize()
        }
        else {
            print("mode is 1")
            mode = 1
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(mode, forKey: "MyKey")
            defaults.synchronize()
        }
        
        performSegueWithIdentifier("switch", sender: self)
        print("switching share button")
    }*/
    
    //MARK: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reset" {
            print("resetting")
            let nav = segue.destination as! UINavigationController
            let screenDetailViewController = nav.topViewController as! LoadingScreenViewController
            screenDetailViewController.reset = 1
        }
    }
}
