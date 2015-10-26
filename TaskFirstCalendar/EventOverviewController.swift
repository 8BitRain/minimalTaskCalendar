//
//  EventOverviewController.swift
//  TaskFirstCalendar
//
//  Created by Eric Smith on 10/20/15.
//  Copyright © 2015 Eric Smith. All rights reserved.
//

import UIKit
import Foundation

class EventOverviewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var events = [EventCell]()
   // var eventStore = [String: [EventCell]]()
    var eventStore = [EventCell]()
    var id = -1
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.addTarget(self, action: Selector("dataPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 90
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //datePicker.date.
        
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        
        if let savedEvents = loadEvents(dateStr){
            var archivedEvents = loadEvents(dateStr)!
            for(var i = 0; i < archivedEvents.count; i++){
                if(archivedEvents[i].date != dateStr){
                    print("removing" + (archivedEvents[i].eventTitle)!)
                    archivedEvents.removeAtIndex(i)
                    i = i - 1
                }
            }
            events = archivedEvents
            //Grab the ID of the last saved event!
            if(events.count != 0){
             id = events[events.count - 1].id
            }
            
        }
        else{
            //loadDefaultDates()
            
        }
        

        table.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func loadDefaultDates(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //datePicker.date.
        
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        
        print(dateStr)
        
        let event1 = EventCell(start_time: "9:30", end_time: "10:30", eventTitle:"You should really finish this app", date:"Fish")
        let event2 = EventCell(start_time: "10:30", end_time: "12:30", eventTitle:"Hi Eric :3", date:"Fish")
        
        events += [event1, event2]
        
    }
    
    func loadOtherDates(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //datePicker.date.
        
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        let event1 = EventCell(start_time: "9:30", end_time: "10:30", eventTitle:"Love", date:"Fish")
        let event2 = EventCell(start_time: "10:30", end_time: "12:30", eventTitle:"Listen", date:"Fish")
        
        events += [event1, event2]
    }*/
    
    //There  needs to be an active events array
    /* 
    The idea behind the next I'm going to make will basically create a new Events array. This array
    will then take the values of events on the date before the datepicker changes, and will add those events to the new event array. Then I will use the date as a hashmap key and store the values of the hashmap
    as the event array. This will be stored using the concept of persistence
    */
    func changeDates(){
    }
    
    
    func dataPickerChanged(datePicker: UIDatePicker){
        //loadOtherDates()
        /*table.deleteRowsAtIndexPaths(table.indexPathsForVisibleRows!, withRowAnimation: UITableViewRowAnimation.Fade)*/
       
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //datePicker.date.
        
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        var archivedEvents = loadEvents(dateStr)!
        for(var i = 0; i < archivedEvents.count; i++){
            if(archivedEvents[i].date != dateStr){
                print("removing" + (archivedEvents[i].eventTitle)!)
                archivedEvents.removeAtIndex(i)
                i = i - 1
            }
        }
        //saveEvents()
        events = archivedEvents
         table.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DateCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DateCell
        let event = events[indexPath.row]
        if(events.count != 0){
            cell.eventText.text = event.eventTitle
            cell.startTime.text = event.start_time
            cell.finishTime.text = event.end_time
        }
        
        
        
        return cell
    }
    

    
    // Override to support editing the table view.
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //Grab the id of the row you are about to delete
            let eventID = events[indexPath.row].id
            // Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            //Loop through ids
            for(var i = 0; i < eventStore.count; i++){
                if(eventStore[i].id == eventID){
                  eventStore.removeAtIndex(i)
                }
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //Save events once removed
            saveEvents()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if(segue.identifier == "ShowDetail"){
            //Get the cell that called the segue
            let addEventController =  segue.destinationViewController as! AddEventController
            if let selectedEventCell = sender as? DateCell {
                
                let indexPath = table.indexPathForCell(selectedEventCell)
                let selectedEvent = events[indexPath!.row]
                
            addEventController.event = selectedEvent
                
            }
            
            
        } else if(segue.identifier == "AddEvent"){
            print("Adding Meal")
            let nav = segue.destinationViewController as! UINavigationController
            let addEventController = nav.topViewController as! AddEventController
            let dateFormatter = NSDateFormatter()
            
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            let dateStr = dateFormatter.stringFromDate(datePicker.date)
            
            //addEventControllerz.date = dateStr
            addEventController.date = dateStr
            addEventController.id = id++
            
            
        }
    }
    
    //This function handles what to do when a user has hit "Save" on the "AddEvent" Page
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddEventController, event = sourceViewController.event{
            
            if let selectedPathIndex = table.indexPathForSelectedRow{
                
                //set edited cells event to the one the user just edited
                events[selectedPathIndex.row] = event
                table.reloadRowsAtIndexPaths([selectedPathIndex], withRowAnimation: .None)
            }
                
            else{
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
                events.append(event)
                eventStore.append(event)
                //tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                table.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            //Save Events
            saveEvents()
        }
    }
    
   // MARK: NSCoding
    
    func saveEvents(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(eventStore, toFile: EventCell.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
        
       
        
    }
    
    func loadEvents(date: String) -> [EventCell]?{
        //var archivedEvents = NSKeyedUnarchiver.unarchiveObjectWithFile(EventCell.ArchiveURL.path!) as? [EventCell]
        return NSKeyedUnarchiver.unarchiveObjectWithFile(EventCell.ArchiveURL.path!) as? [EventCell]
    }
    
    
    
}