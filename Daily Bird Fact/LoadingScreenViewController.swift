//
//  LoadingScreen.swift
//  Daily Bird Facts
//
//  Created by Alex Philpott on 7/14/16.
//  Copyright © 2016 Philpott Studios. All rights reserved.
//

import UIKit
import CloudKit
import Foundation

let factNotifKey = "com.philpottstudios.factNotificationKey"
let checkedNotifKey = "com.philpottstudios.checkedNotificationKey"



class LoadingScreenViewController: UIViewController{
    
    //PROPERTIES
    var birdFacts = [CKRecord]()
    var reset: Int = 0
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loadingPicture: UIImageView!
    @IBOutlet weak var loadingCaption: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        errorLabel.isHidden = true
        
        if reset != 0 {
            print("reset mode enabled, removing all bird facts")
            birdFacts.removeAll()
        }
        
        let random = Int(arc4random_uniform(17) + 1)
        
        switch random {
        case 1:
            let photo1 = UIImage(named: "Acorn Woodpecker (Melanerpes formicivorus)")
            loadingPicture.image = photo1
            loadingCaption.text = "Acorn Woodpecker (Melanerpes formicivorus)"
        case 2:
            let photo2 = UIImage(named: "African Red-billed Hornbill (Tockus erythrorhynchus)")
            loadingPicture.image = photo2
            loadingCaption.text = "African Red-billed Hornbill (Tockus erythrorhynchus)"
        case 3:
            let photo3 = UIImage(named: "Barn Owl (Tyto alba)")
            loadingPicture.image = photo3
            loadingCaption.text = "Barn Owl (Tyto alba)"
        case 4:
            let photo4 = UIImage(named: "Broad-tailed Hummingbird (Selasphorus platycercus)")
            loadingPicture.image = photo4
            loadingCaption.text = "Broad-tailed Hummingbird (Selasphorus platycercus)"
        case 5:
            let photo5 = UIImage(named: "Costa’s Hummingbird (Calypso costae)")
            loadingPicture.image = photo5
            loadingCaption.text = "Costa’s Hummingbird (Calypso costae)"
        case 6:
            let photo6 = UIImage(named: "Double-wattled Cassowary (Casuarius casuarius)")
            loadingPicture.image = photo6
            loadingCaption.text = "Double-wattled Cassowary (Casuarius casuarius)"
        case 7:
            let photo7 = UIImage(named: "European Robin (Erithacus rubecula)")
            loadingPicture.image = photo7
            loadingCaption.text = "European Robin (Erithacus rubecula)"
        case 8:
            let photo8 = UIImage(named: "Fiery-throated Hummingbird (Panterpe insignis)")
            loadingPicture.image = photo8
            loadingCaption.text = "Fiery-throated Hummingbird (Panterpe insignis)"
        case 9:
            let photo9 = UIImage(named: "Goldfinch (Carduelis carduelis)")
            loadingPicture.image = photo9
            loadingCaption.text = "Goldfinch (Carduelis carduelis)"
        case 10:
            let photo10 = UIImage(named: "Hyacinth Macaw (Anodorhynchus hyacinthinus)")
            loadingPicture.image = photo10
            loadingCaption.text = "Hyacinth Macaw (Anodorhynchus hyacinthinus)"
        case 11:
            let photo11 = UIImage(named: "Indian Peafowl (Pavo cristata)")
            loadingPicture.image = photo11
            loadingCaption.text = "Indian Peafowl (Pavo cristata)"
        case 12:
            let photo12 = UIImage(named: "Indian Roller (Coracias benghalensis)")
            loadingPicture.image = photo12
            loadingCaption.text = "Indian Roller (Coracias benghalensis)"
        case 13:
            let photo13 = UIImage(named: "Kea (Nestor notabilis)")
            loadingPicture.image = photo13
            loadingCaption.text = "Kea (Nestor notabilis)"
        case 14:
            let photo14 = UIImage(named: "Lilac Breasted Roller (Coracias caudata)")
            loadingPicture.image = photo14
            loadingCaption.text = "Lilac Breasted Roller (Coracias caudata)"
        case 15:
            let photo15 = UIImage(named: "Red-winged Blackbird (Agelaius phoeniceus)")
            loadingPicture.image = photo15
            loadingCaption.text = "Red-winged Blackbird (Agelaius phoeniceus)"
        case 16:
            let photo16 = UIImage(named: "Scarlet Macaw (Ara macao)")
            loadingPicture.image = photo16
            loadingCaption.text = "Scarlet Macaw (Ara macao)"
        case 17:
            let photo17 = UIImage(named: "West African Crowned Crane (Balearica pavonina pavonina)")
            loadingPicture.image = photo17
            loadingCaption.text = "West African Crowned Crane (Balearica pavonina pavonina)"
        default:
            print("error in switch")
        }
        
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoadingScreenViewController.factsChecked), name: NSNotification.Name(rawValue: checkedNotifKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoadingScreenViewController.factsDownloaded), name: NSNotification.Name(rawValue: factNotifKey), object: nil)
        
        activity.startAnimating()
        
        /*if reset == 0 {
            statusLabel.text = "Loading saved facts..."
            let savedFacts = loadFacts()
            if savedFacts != nil {
                birdFacts = savedFacts!
                if birdFacts.count != 0 {
                    print("successfully loaded saved bird facts")
                    print("checking for pictures")
                    checkFacts()
                }
            }
        }*/
        
        print("getting today's date")
        let date = getDate()
        print("todays date is", date)
        
        print("getting date")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        print("creating olddate")
        let olddate = formatter.date(from: "20160601")
        print(olddate)
        print("olddate made")
        
        if reset != 0 {
            statusLabel.text = "Resetting facts..."
            print("resetting facts")
            allprevFacts(date, olddate: olddate!)
        }
        else if birdFacts.count == 0 {
            statusLabel.text = "Fetching new facts..."
            //DEVELOPER:
            //allFacts()
            
            //DISTRIBUMENT:
            allprevFacts(date, olddate: olddate!)
            print("olddate is 0")
        }
        else {
            statusLabel.text = "Fetching new facts..."
            //print("running else loop")
            print("accessing first bird fact to pass into allprevFacts")
            let olddate = birdFacts[0].value(forKey: "date") as! Date
            //let recentFact = birdFacts[0]
            allprevFacts(date, olddate: olddate)
            print("olddate exists")
        }
        
        
        

        
    }
    
    func factsChecked() {
        activity.stopAnimating()
        
        performSegue(withIdentifier: "load", sender: self)
        
        print("seguing, all facts are checked")
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func factsDownloaded() {
        activity.stopAnimating()
        
        /*if reset != 0 {
            //checkFacts()
            saveFacts()
        }*/
        print("setting reset to 0")
        reset = 0
        
        performSegue(withIdentifier: "load", sender: self)
        
        print("facts downloaded, seguing")
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "load" {
            let nav = segue.destination as! UINavigationController
            let tableDetailViewController = nav.topViewController as! BirdFactTableViewController
            tableDetailViewController.birdFacts = birdFacts
        }
    }
    
    func checkRepeatingFacts() -> Bool{
        var indfor: Int = 1
        var x: Bool = false
        var prevFact: Int = 0
        let currentFact: Int = 0
        var prevInd: Int = -1
        var curInd: Int = -1
        if birdFacts.count != 0 {
            print("accessing first bird fact in checkRepeatingFacts")
            print("count is", birdFacts.count)
            var prevFact = birdFacts[0].value(forKey: "sortingDate") as! Int
            print(prevFact)
            prevInd = 0
        }
        while indfor < birdFacts.count {
            print("accessing current bird fact in checkRepeatingFacts")
            if indfor < birdFacts.count {
                let currentFact = birdFacts[indfor].value(forKey: "sortingDate") as! Int
                curInd = indfor
            }
            if currentFact == prevFact {
                //print("removing duplicate fact")
                //birdFacts.removeAtIndex(prevInd)
                x = true
                print("duplicate facts detected and removed")
            }

            prevFact = currentFact
            prevInd = curInd
            indfor = indfor + 1
            
        }
        print("finished checking for duplicates, returning", x)
        return x
    }
    
    func checkFacts() {
        statusLabel.text = "Verifying facts aren't corrupted..."
        print("checking for facts")
        let date = getDate()
        var x: Bool = true
        var ind: Int = 0
        let y = checkRepeatingFacts()
        if y {
            print("removing all facts")
            birdFacts.removeAll()
        }
        
        if y == false {
            NotificationCenter.default.post(name: Notification.Name(rawValue: checkedNotifKey), object: self)
        }
        print("count is ", birdFacts.count)
        while ind < birdFacts.count {
            print("accessing each bird fact in checkFacts")
            let imageAsset: CKAsset = birdFacts[ind].value(forKey: "birdPicture") as! CKAsset
            let image = UIImage(contentsOfFile: imageAsset.fileURL.path)
            print(image)
            if image == nil {
                if (birdFacts[ind].value(forKey: "sortingDate") != nil){
                    print("replacing fact")
                    print("accessing the sortingDate of current fact in checkFacts")
                    let sdate = birdFacts[ind].value(forKey: "sortingDate") as! NSNumber
                    replaceFact(sdate, index: ind)
                }
                /*else {
                 birdFacts.removeAll()
                 print("removing all bird facts")
                 }*/
                
            }
            ind = ind + 1
            print(ind)
        }
        self.saveFacts()
    }
    
    func getDate () -> String {
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: NSCalendar.Unit = [
            NSCalendar.Unit.year,
            NSCalendar.Unit.month,
            NSCalendar.Unit.day,
            ]
        
        // get the components
        let dateTimeComponents = (userCalendar as NSCalendar).components(requestedComponents, from: currentDateTime)
        let date = String(describing: dateTimeComponents.year) + String(describing: dateTimeComponents.month) + String(describing: dateTimeComponents.day)
        return date
    }
    
    func replaceFact(_ sdate: NSNumber, index: Int){
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        let factPredicate = NSPredicate(format: "sortingDate = %@", sdate)
        //let factPredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "BirdFacts", predicate: factPredicate)
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                DispatchQueue.main.async{
                    //print(results)
                    for result in results! {
                        if index < self.birdFacts.count {
                            print("index is ", index)
                            print("removing selected fact from birdFacts in replaceFact")
                            self.birdFacts.remove(at: index)
                            self.birdFacts.insert(result , at: index)
                        }
                    }
                    print("finished replaceFact for loop")
                    self.saveFacts()
                }
            }
        }
        print("fetched fact")
    }
    
    func allprevFacts(_ date: String, olddate: Date){
        print("fetching all previous facts")
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        //let factPredicate = NSPredicate(format: "recordID = %@", CKRecordID(recordName: date))
        let factPredicate = NSPredicate(format: "date <= %@", Date() as CVarArg)
        let datePredicate = NSPredicate(format: "date > %@", olddate as CVarArg)
        let comboPredicate = NSCompoundPredicate(type: .and, subpredicates: [factPredicate, datePredicate])
        let query = CKQuery(recordType: "BirdFacts", predicate: comboPredicate)
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                self.errorLabel.isHidden = false
                
                self.activity.stopAnimating()
                
                print(error)
            }
            else {
                DispatchQueue.main.async{
                    self.statusLabel.text = "Facts downloading..."
                    //print(results)
                    /*var count = 0
                    var sortedresults = [Int]()
                    for result in results! {
                        var b = result.valueForKey("sortingDate") as! Int
                        sortedresults.append(b)
                    }
                    //print(sortedresults)
                    while count < sortedresults.count {
                        if sortedresults[count] <= olddate {
                            sortedresults.removeAtIndex(count)
                        }
                        else {
                            count = count + 1
                        }
                    }
                    //print(sortedresults)
                    for fact in sortedresults {
                        for fact2 in results! {
                            if fact == fact2.valueForKey("sortingDate") as! Int {
                                self.birdFacts.append(fact2)
                                print(fact, "appended")
                            }
                        }
                    }*/
                    for fact in results! {
                        self.birdFacts.append(fact)
                    }
                    print("sorting bird facts")
                    self.birdFacts = self.sortArray(self.birdFacts)
                    print("bird facts sorted")
                    self.saveFacts()
                    //print("checking facts for pictures & duplicates")
                    //self.checkFacts()
                    NotificationCenter.default.post(name: Notification.Name(rawValue: factNotifKey), object: self)
                }
            }
        }
    }
    
    func sortArray(_ start: [CKRecord]) -> [CKRecord]{
        //print(start)
        var d = 0
        var h = 0
        var i = 0
        var g = [TimeInterval]()
        var b = [CKRecord]()
        while h < start.count {
            g.append((start[h].value(forKey: "date")! as AnyObject).timeIntervalSince1970)
            h = h + 1
        }
        //print(g)
        while g.count > 0 {
            i = 0
            d = 0
            let a = g.max()
            //print(a)
            while i < g.count {
                if g[i] == a {
                    g.remove(at: i)
                    break
                }
                i = i + 1
            }
            while d < start.count {
                if (start[d].value(forKey: "date")! as AnyObject).timeIntervalSince1970 == a {
                    //b.insert(start[d],atIndex: 0)
                    b.append(start[d])
                }
                d = d + 1
            }
            //print(b.count)
        }
        //print(b)
        return b
    }
    
    //MARK: NSCODING
    func saveFacts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(birdFacts, toFile: BirdFact.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save bird facts")
        }
        else {
            print("saved bird facts")
            let filepath = BirdFact.ArchiveURL.path
            /*let skipBackup = addSkipBackupAttributeToItemAtURL(filepath)
            if skipBackup {
                print("bird facts will not be backed up")
            }
            else {
                print("bird facts will be backed up")
            }*/
        }
    }
    
    func loadFacts() -> [CKRecord]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: BirdFact.ArchiveURL.path) as? [CKRecord]
    }
    
    /*func addSkipBackupAttributeToItemAtURL(_ filePath:String) -> Bool {
        let URL:Foundation.URL = URL(fileURLWithPath: filePath)
        
        assert(FileManager.default.fileExists(atPath: filePath), "File \(filePath) does not exist")
        
        var success: Bool
        do {
            try (URL as NSURL).setResourceValue(true, forKey:URLResourceKey.isExcludedFromBackupKey)
            success = true
        } catch let error as NSError {
            success = false
            print("Error excluding \(URL.lastPathComponent) from backup \(error)");
        }
        
        return success
    }*/

}
