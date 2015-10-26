//
//  DateOverviewController.swift
//  TaskFirstCalendar
//
//  Created by Eric Smith on 10/11/15.
//  Copyright © 2015 Eric Smith. All rights reserved.
//

import UIKit
import Foundation

class DateOverviewController : UITableViewController{
    var events = [EventCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultDates()
    }
    
    func loadDefaultDates(){
        let event1 = EventCell(start_time: "9:30", end_time: "10:30", eventTitle:"You should really finish this app")
        let event2 = EventCell(start_time: "10:30", end_time: "12:30", eventTitle:"Hi Eric :3")
        
        events += [event1, event2]
        
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddEventController, event = sourceViewController.event {
            // Add a new meal.
            let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
            events.append(event)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DateCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DateCell
        let event = events[indexPath.row]
        cell.eventText.text = event.eventTitle
        cell.startTime.text = event.start_time
        cell.finishTime.text = event.end_time
        
        
        
        return cell
    }
    
    

}
