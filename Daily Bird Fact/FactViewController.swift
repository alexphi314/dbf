//
//  FactViewController.swift
//  Daily Bird Fact
//
//  Created by Alex Philpott on 5/16/16.
//  Copyright © 2016 Philpott Studios. All rights reserved.
//

import UIKit
import CloudKit
import Social

class FactViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var birdName: UILabel!
    @IBOutlet weak var birdPicture: UIImageView!
    @IBOutlet weak var birdFact: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var birdf: CKRecord?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = UserDefaults.standard
        var mode = defaults.integer(forKey: "MyKey")
        
        /*if mode == 1 {
            shareButton.setTitle("Share on Facebook", forState: .Normal)
        }
        else {
            shareButton.setTitle("Share on Twitter", forState: .Normal)
        }*/
    }
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //re-sizing label 
        let lcCurrentWidth = self.view.frame.size.width

        birdFact.sizeToFit()
        
        //Set up views for viewing a bird fact
        if let birdf = birdf {
            birdName.text = birdf.value(forKey: "birdName") as? String
            birdFact.text = birdf.value(forKey: "birdFact") as? String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            navigationItem.title = dateFormatter.string(from: birdf.value(forKey: "date") as! Date)
            
            let imageAsset: CKAsset = birdf.value(forKey: "birdPicture") as! CKAsset
            birdPicture.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
            
            caption.text = birdf.value(forKey: "caption") as? String
            
        }
        
        /*//setting up Facebook share button
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentTitle = birdName.text!
        content.contentDescription = birdFact.text!
        
        let button : FBSDKShareButton = FBSDKShareButton()
        button.shareContent = content
        button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 108), (UIScreen.mainScreen().bounds.height-33), 100, 25)
        self.view.addSubview(button)*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Navigation
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openLink(_ sender: UIButton) {
        let link2 = birdName.text!
        let link3 = link2.replacingOccurrences(of: " ", with: "+") //EDIT
        guard
            let query = link3.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://google.com/#q=\(query)")
            else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func shareFacebook(_ sender: AnyObject) {
        /*let defaults = NSUserDefaults.standardUserDefaults()
        let mode = defaults.integerForKey("MyKey")
        print("mode is", mode)
        if mode == 1 {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.addImage(birdPicture.image)
                facebookSheet.addURL(NSURL(string: "https://itunes.apple.com/us/app/daily-bird-facts/id1120364934?mt=8"))
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

        }
        
        else {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterSheet: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.addImage(birdPicture.image)
                twitterSheet.setInitialText("Check out today's bird from Daily Bird Facts!")
                twitterSheet.addURL(NSURL(string: "https://itunes.apple.com/us/app/daily-bird-facts/id1120364934?mt=8"))
                self.presentViewController(twitterSheet, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }*/
        var shareText = "Check out today's bird from Daily Bird Facts, "
        shareText = shareText + birdName.text! + "!"
        //print(shareText)
        let shareImage = birdPicture.image
        //let shareURL = NSURL(string: "https://itunes.apple.com/us/app/daily-bird-facts/id1120364934?mt=8")
        let vc = UIActivityViewController(activityItems: [shareText,shareImage!], applicationActivities: [])
        if let wPPC = vc.popoverPresentationController {
            wPPC.sourceView = super.view
            wPPC.sourceRect = CGRect(x: shareButton.center.x, y: shareButton.center.y, width: 1, height: 1)
        }
        present(vc, animated: true, completion: nil)
    }
}

