//
//  MainViewController.swift
//  CalendarPractice
//
//  Created by 이광용 on 2017. 12. 22..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import WRCalendarView

class MainViewController: UIViewController {
    @IBOutlet weak var weekView: WRWeekView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCalendarData()
        weekView.calendarType = .day
        var event = WREvent.make(date: Date(), chunk: 50.minutes, title: "Test")
        
        weekView.addEvent(event: event)
        
    }

    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self
    }

}

extension MainViewController: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
    }
    
    func tap(date: Date) {
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print(event.title)
    }
    
    
}
