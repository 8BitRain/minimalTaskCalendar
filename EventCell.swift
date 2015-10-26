//
//  EventCell.swift
//  TaskFirstCalendar
//
//  Created by Eric Smith on 10/12/15.
//  Copyright © 2015 Eric Smith. All rights reserved.
//


import UIKit
import Foundation


class EventCell: NSObject, NSCoding{
    var start_time: String!
    var end_time: String!
    var eventTitle: String!
    var date: String!
    var id: Int!
    
    //MARK Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory,
        inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    init(start_time: String, end_time: String, eventTitle: String, date: String, id: Int){
        self.start_time = start_time
        self.end_time = end_time
        self.eventTitle = eventTitle
        self.date = date
        self.id = id
        
        super.init()
    }
    
    struct PropertyKey{
        static let eventTitleKey = "eventTitle"
        static let eventEndKey = "start_time"
        static let eventStartKey = "end_time"
        static let date = "date"
        static let id = "id"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(eventTitle, forKey: PropertyKey.eventTitleKey)
        aCoder.encodeObject(start_time, forKey: PropertyKey.eventStartKey)
        aCoder.encodeObject(end_time, forKey: PropertyKey.eventEndKey)
        aCoder.encodeObject(date, forKey: PropertyKey.date)
        aCoder.encodeInteger(id, forKey: PropertyKey.id)
    
        
       
    }
    
    
    required convenience init?(coder aDecoder:NSCoder){
        let eventTitle = aDecoder.decodeObjectForKey(PropertyKey.eventTitleKey) as! String
        //Note both start and end time are made (optionals) because I want the user to enter no start and end time
        
        let start_time = aDecoder.decodeObjectForKey(PropertyKey.eventStartKey) as! String
        let end_time = aDecoder.decodeObjectForKey(PropertyKey.eventEndKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.date) as! String
        let id = aDecoder.decodeIntegerForKey(PropertyKey.id) 
        
        self.init(start_time: start_time, end_time: end_time, eventTitle: eventTitle, date: date, id: id)
        
        
    }
    
   
    
}