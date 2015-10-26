//
//  CalendarController.swift
//  TaskFirstCalendar
//
//  Created by Eric Smith on 10/16/15.
//  Copyright © 2015 Eric Smith. All rights reserved.
//

import UIKit

class CalendarController : UIViewController, JTCalendarDelegate {
    
    @IBOutlet weak var calendarMenuView: UIView!
    //JTCalendarManager calendarManager
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // JTD
        let calendarManager = JTCalendarManager()
        calendarManager.delegate = self
        calendarManager.
        
        
        
        //self.dataSource = self
       // JTCalendarDelegate.calendar(self)
        //CalendarController.calendarBuildMenuItemView(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}








