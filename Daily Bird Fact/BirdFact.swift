//
//  BirdFact.swift
//  Daily Bird Fact
//
//  Created by Alex Philpott on 5/16/16.
//  Copyright © 2016 Philpott Studios. All rights reserved.
//

import UIKit
import CloudKit

class BirdFact: NSObject, NSCoding {
    //MARK: PROPERTIES
    var birdName: String
    
    var photo: CKAsset
    
    var birdFact: String
    
    var date: Date
    
    var sortingDate: Int
    
    var caption: String
    
    //MARK: TYPES
    struct PropertyKey {
        static let namekey = "name"
        static let photokey = "photo"
        static let factkey = "fact"
        static let datekey = "date"
        static let sortingDatekey = "sortingDate"
        static let captionkey = "caption"
    }
    
    //MARK: ARCHIVING PATHS
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("BirdFacts")
    
    //MARK: INITIALIZATION
    
    init?(birdName: String, photo: CKAsset, birdFact: String, date: Date, sortingDate: Int, caption: String){
        //init stored props
        self.birdName = birdName
        self.photo = photo
        self.birdFact = birdFact
        self.date = date
        self.sortingDate = sortingDate
        self.caption = caption
        
        super.init()
        
        if birdName.isEmpty || birdFact.isEmpty || caption.isEmpty{
            return nil
        }
    }
    
    //MARK: NSCODING
    func encode(with aCoder: NSCoder) {
        aCoder.encode(birdName, forKey: PropertyKey.namekey)
        aCoder.encode(photo, forKey: PropertyKey.photokey)
        aCoder.encode(birdFact, forKey: PropertyKey.factkey)
        aCoder.encode(date, forKey: PropertyKey.datekey)
        aCoder.encode(sortingDate, forKey: PropertyKey.sortingDatekey)
        aCoder.encode(caption, forKey: PropertyKey.captionkey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let birdName = aDecoder.decodeObject(forKey: PropertyKey.namekey) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photokey) as! CKAsset
        let birdFact = aDecoder.decodeObject(forKey: PropertyKey.factkey) as! String
        let date = aDecoder.decodeObject(forKey: PropertyKey.datekey) as! Date
        let sortingDate = aDecoder.decodeObject(forKey: PropertyKey.sortingDatekey) as! Int
        let caption = aDecoder.decodeObject(forKey: PropertyKey.captionkey) as! String
        
        self.init(birdName: birdName, photo: photo, birdFact: birdFact, date: date, sortingDate: sortingDate, caption: caption)
    }
    
}
