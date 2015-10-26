//
//  AddEventController.swift
//  TaskFirstCalendar
//
//  Created by Eric Smith on 10/20/15.
//  Copyright © 2015 Eric Smith. All rights reserved.
//

import UIKit
import Foundation

class AddEventController : UIViewController{
    
    var event : EventCell?
    var date : String!
    var id : Int!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let event = event{
            eventTitle.text = event.eventTitle
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        if(isPresentingInAddEventMode){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            navigationController!.popViewControllerAnimated(true)
        }
  
    }
    
    @IBOutlet weak var eventTitle: UITextField!
    
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var endTime: UITextField!
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(saveButton === sender){
            let eventCellTitle = eventTitle.text ?? ""
            let eventCellStart = startTime.text ?? ""
            let eventCellEnd = endTime.text ?? ""
            
            event = EventCell(start_time: eventCellStart, end_time: eventCellEnd, eventTitle: eventCellTitle, date: date, id: id)

            
        }
    }
    
    
    
    
    
    
}