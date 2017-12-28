//
//  BirdFactTableViewController.swift
//  Daily Bird Fact
//
//  Created by Alex Philpott on 5/17/16.
//  Copyright © 2016 Philpott Studios. All rights reserved.
//

import UIKit
import CloudKit

class BirdFactTableViewController: UITableViewController {

    @IBOutlet var tableFacts: UITableView!
    @IBOutlet var act: UIActivityIndicatorView!
    
    //MARK: PROPERTIES
    var birdFacts = [CKRecord]()
    //var reset: Int = 0
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        let date = getDate()

        todaysFact(date)
        
        self.refreshControl?.endRefreshing()
        
        //testing replace facts
        /*print("replacing first fact")
        let sdate = birdFacts[0].valueForKey("sortingDate")
        print(sdate)
        print("running replaceFact")
        replaceFact(sdate as! NSNumber, index: 0)
        checkFacts()*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        /*if reset != 0 {
            print("removing all bird facts")
            birdFacts.removeAll()
        }*/
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //asking permission to notify
        //let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        //UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)

        
        //Creating empty "error" label
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        emptyLabel.numberOfLines = 2
        emptyLabel.text = "Cannot fetch bird facts. Are you signed into iCloud?"
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.textColor = UIColor.white
        self.tableView.backgroundView = emptyLabel
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        emptyLabel.isHidden = true
        
        //Creating empty "reset" label
        let resetLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        resetLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        resetLabel.numberOfLines = 2
        resetLabel.text = "Re-fetching facts, please be patient"
        resetLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = resetLabel
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        resetLabel.isHidden = true

        /*if reset != 0 {
            emptyLabel.hidden = true
            resetLabel.hidden = false
        }*/
        
        //tableFacts.hidden = true
        
        //Loading saved bird facts
        //var z: Bool = false
        //var y: Bool = false
        /*let savedFacts = loadFacts()
        if reset == 0 {
            if savedFacts != nil{
                birdFacts = savedFacts!
                print("successfully loaded saved bird facts")
                print("checking for pictures")
                checkFacts()
            }
        }*/
        
        //print(birdFacts[0].valueForKey("birdPicture"))
        
        let date = getDate()
        
        //Load all new bird facts
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        /*if reset != 0 {
            print("resetting facts")
            allprevFacts(date, olddate: 0)
        }*/
        /*else if birdFacts.count == 0 {
            //DEVELOPER:
            //allFacts()
            
            //DISTRIBUMENT:
            allprevFacts(date, olddate: 0)
            print("olddate is 0")
        }
        else {
            print("running else loop")
            print("accessing first bird fact to pass into allprevFacts")
            let olddate = birdFacts[0].valueForKey("sortingDate") as! Int
            //let recentFact = birdFacts[0]
            allprevFacts(date, olddate: olddate)
            print("olddate exists")
        }*/
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        //checking for pictures
        //checkFacts()
        
        /*Load all previous bird facts
        if birdFacts.count == 0 {
            act.startAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            allprevFacts(date, olddate: olddate)
            print("loading all previous facts")
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            act.stopAnimating()
        }*/
        
         self.refreshControl?.addTarget(self, action: #selector(BirdFactTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        
        //load sample data
        //loadSampleFacts()
    
        //print(birdFacts)
        /*if birdFacts.count == 0 {
            tableFacts.hidden = false
            emptyLabel.hidden = false
        }*/
        
        /*if reset != 0 {
            checkFacts()
            saveFacts()
            print("setting reset to 0")
            reset = 0 
        }*/
        
        /*print("checking for duplicate facts")
        if birdFacts.count != 0{
            let y = checkRepeatingFacts()
        }
        if z != false {
            if y != false {
                print("removing all bird facts and re-downloading")
                birdFacts.removeAll()
                allprevFacts(date, olddate: 0)
            }
        }*/
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return birdFacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "BirdFactTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BirdFactTableViewCell
        
        //fetches appropriate fact
        //print("accessing each bird fact to build table")
        let birdFact = birdFacts[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = birdFact.value(forKey: "birdName") as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        cell.dateLabel.text = dateFormatter.string(from: birdFact.value(forKey: "date") as! Date)
        
        let imageAsset: CKAsset = birdFact.value(forKey: "birdPicture") as! CKAsset
        cell.photoImageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        
        //print(cell.photoImageView.image)
        
        /*if cell.photoImageView.image == nil {
            birdFacts.removeAll()
            allprevFacts(date, olddate: 0)
        }*/
        
        /*if let image = birdFact.valueForKey("birdPicture") as? CKAsset{
            print("image found")
            if let data = NSData(contentsOfURL: NSURL(fileURLWithPath: BirdFact.ArchiveURL.path!)){
                cell.photoImageView.image = UIImage(data: data)
                print("cell photo done")
            }
        }*/
        
        
        
        return cell
    }
    
    /*func loadSampleFacts(){
        let photo3 = UIImage(named: "5152016")!
        let fact3 = BirdFact(birdName: "Edward's Lorikeet", photo: photo3, birdFact: "Lorikeets have bristles on their tongues that act like toothbrushes, helping them drink nectar", date: "5/15/2016")
        
        let photo2 = UIImage(named: "5162016")!
        let fact2 = BirdFact(birdName: "Stella's Lorikeet", photo: photo2, birdFact: "There are a wide range of colors between the many species of lorikeets", date: "5/16/2016")
        
        let photo1 = UIImage(named: "5172016")!
        let fact1 = BirdFact(birdName: "Blue-Streaked Lory", photo: photo1, birdFact: "Lories can be differentiated from lorikeets by their short and square tails and the fact that they are generally red while lorikeets are green", date: "5/17/2016")

        birdFacts.append(fact1!)
        birdFacts.append(fact2!)
        birdFacts.append(fact3!)
        
    }*/
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFact" {
            let nav = segue.destination as! UINavigationController
            let factDetailViewController = nav.topViewController as! FactViewController
            // Get the cell that generated this segue.
            if let selectedFactCell = sender as? BirdFactTableViewCell {
                let indexPath = tableView.indexPath(for: selectedFactCell)!
                let selectedFact = birdFacts[(indexPath as NSIndexPath).row]
                factDetailViewController.birdf = selectedFact
                
            }
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
            var prevFact = birdFacts[0].value(forKey: "sortingDate") as! Int
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
                print("duplicate facts detected")
            }
            prevFact = currentFact
            prevInd = curInd
            indfor = indfor + 1
        }
        print("finished checking for duplicates, returning", x)
        return x
    }
    
    func checkFacts(_ block: (()->Void)? = nil) {
        let date = getDate()
        var x: Bool = true
        var ind: Int = 0
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
        let y = checkRepeatingFacts()
        if y {
            print("removing all facts")
            birdFacts.removeAll()
            allprevFacts(date, olddate: 0)
        }
        
        // CALL CODE IN CLOSURE LAST //
        if let block = block {
            block()
        }
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
                            self.tableFacts.reloadData()
                            self.tableFacts.isHidden = false
                        }
                    }
                    print("finished replaceFact for loop")
                    self.saveFacts()
                    self.tableFacts.isHidden = false
                }
            }
        }
        print("fetched fact")
    }
    
    func todaysFact(_ date: String){
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        let factPredicate = NSPredicate(format: "recordID = %@", CKRecordID(recordName: date))
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
                        print("accessing first bird fact in todaysFact")
                        if result.value(forKey: "sortingDate") as! Int == self.birdFacts[0].value(forKey: "sortingDate") as! Int {
                            print("today's fact already imported")
                        }
                        else {
                            self.birdFacts.insert(result , at: 0)
                            self.tableFacts.reloadData()
                            self.tableFacts.isHidden = false
                        }
                        
                    }
                    self.saveFacts()
                    self.tableFacts.isHidden = false
                }
            }
        }
        saveFacts()
        print("fetched fact")
    }

    func allFacts(){
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        let factPredicate = NSPredicate(value: true)
        //let factPredicate = NSPredicate(format: "date <= %@", NSDate())
        let query = CKQuery(recordType: "BirdFacts", predicate: factPredicate)
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                DispatchQueue.main.async{
                    for result in results! {
                        print("result appended to bird fact array")
                        self.birdFacts.append(result)
                    }
                    print("sorting bird facts")
                    self.birdFacts = self.sortArray(self.birdFacts)
                    print("bird facts sorted")
                    self.tableFacts.reloadData()
                    self.saveFacts()
                    self.tableFacts.isHidden = false
                }
            }
        }
    }
    
    
    func allprevFacts(_ date: String, olddate: Int){
        print("fetching all previous facts")
        let container = CKContainer.default()
        let publicDB = container.publicCloudDatabase
        //let factPredicate = NSPredicate(format: "recordID = %@", CKRecordID(recordName: date))
        let factPredicate = NSPredicate(format: "date <= %@", Date() as CVarArg)
        let query = CKQuery(recordType: "BirdFacts", predicate: factPredicate)
        publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                DispatchQueue.main.async{
                    //print(results)
                    var count = 0
                    var sortedresults = [Int]()
                    for result in results! {
                        let b = result.value(forKey: "sortingDate") as! Int
                        sortedresults.append(b)
                    }
                    //print(sortedresults)
                    while count < sortedresults.count {
                        if sortedresults[count] <= olddate {
                            sortedresults.remove(at: count)
                        }
                        else {
                            count = count + 1
                        }
                    }
                    //print(sortedresults)
                    for fact in sortedresults {
                        for fact2 in results! {
                            if fact == fact2.value(forKey: "sortingDate") as! Int {
                                self.birdFacts.append(fact2)
                                print(fact, "appended")
                            }
                        }
                    }
                    print("sorting bird facts")
                    self.birdFacts = self.sortArray(self.birdFacts)
                    print("bird facts sorted")
                    self.tableFacts.reloadData()
                    self.saveFacts()
                    self.tableFacts.isHidden = false
                    print("checking facts for pictures & duplicates")
                    self.checkFacts()
                }
            }
        }
    }
    
    func dateToFire(_ hour: Int, min: Int, sec: Int) -> Date {
        var calendar = Calendar.current
        var calendarComponents = DateComponents()
        calendarComponents.hour = hour
        calendarComponents.second = sec
        calendarComponents.minute = min
        calendar.timeZone = TimeZone.current
        let dateToFire = calendar.date(from: calendarComponents)
        return dateToFire!
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
