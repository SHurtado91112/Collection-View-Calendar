//
//  ViewController.swift
//  CalendarTrial
//
//  Created by Steven Hurtado on 9/16/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var calendarView: UICollectionView!
    
    let backColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 0.5)
    let txtColor = UIColor(red: (134/255.0), green: (144/255.0), blue: (255/255.0), alpha: 0.2)
    
    let currDate = Date()
    let dateFormatter: DateFormatter = DateFormatter()

    var month: Int = 0
    var year: Int = 0
    var day: Int = 0
    var blocksPerMonth: Int = 0
    var firstDayOfWeek: Int = 0
    var firstWeekShift: Bool = true
    
    let daysPerWeek: Int = 7
    var currRow: Int = 0
    var monthIndex: Int = 0
    var daysCounter: Int = 0
    var initialLoad = true
    var reload = true
    
    var daysPerMonth:[(month: String, days: Int)] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView!.register(CellView.self, forCellWithReuseIdentifier: "cell")
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: currDate)
        
        reload = true
        
        print("\n\n\(weekDay)\n\n")
        
        if(initialLoad)
        {
            let unitFlags = Set<Calendar.Component>([.day, .month, .year])
            
            let components = Calendar.current.dateComponents(unitFlags, from: currDate)
            dateFormatter.dateStyle = .short
            day = components.day!
            month = components.month!
            year = components.year!
            
            daysPerMonth.append(("January", 31))
            
            if((year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0))
            {
                daysPerMonth.append(("February", 29))
            }
            else
            {
                daysPerMonth.append(("February", 28))
            }
            
            
            daysPerMonth.append(("March", 31))
            daysPerMonth.append(("April", 30))
            daysPerMonth.append(("May", 31))
            daysPerMonth.append(("June", 30))
            daysPerMonth.append(("July", 31))
            daysPerMonth.append(("August", 31))
            daysPerMonth.append(("September", 30))
            daysPerMonth.append(("October", 31))
            daysPerMonth.append(("November", 30))
            daysPerMonth.append(("December", 31))
            
            
            monthIndex = month - 1
            
            initialLoad = false
        }
        
        if(reload)
        {
            month = monthIndex + 1
            
            if((year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0))
            {
                daysPerMonth[1] = ("February", 29)
            }
            else
            {
                daysPerMonth[1] = ("February", 28)
            }
            
            firstWeekShift = true
            
            let a = ((14-month)/12)
            let y = year-a;
            let m = month+12*a-2;
            firstDayOfWeek = (1+y+y/4-y/100+y/400+31*m/12)%7
            
            calendarView.reloadData()
            
            reload = false
        }
        
        monthLabel.text = "\(daysPerMonth[monthIndex].month) \(year)"
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
//        let dPM = daysPerMonth[monthIndex].days
        let rows = 6//ceil((Double)(firstDayOfWeek+dPM)/7)
        let blocks = rows*7
        return Int(blocks)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:CellView=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellView;
        

        currRow += 1;
        
        if(currRow >= 7)
        {
            firstWeekShift = false
        }
        
        if(currRow > 7)
        {
            currRow = 1
        }
        
        if(currRow == 1 || currRow == 7)
        {
            cell.backgroundColor = txtColor;
        }
        else
        {
            cell.backgroundColor = backColor;
        }
        
        if(!firstWeekShift)
        {
            cell.dayLabel.text = String(indexPath.row + 1 - firstDayOfWeek)
            if(indexPath.row + 1 - firstDayOfWeek > daysPerMonth[monthIndex].days || indexPath.row + 1 - firstDayOfWeek <= 0)
            {
                cell.dayLabel.text = ""
            }
        }
        
        
        return cell
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        monthIndex += 1
        if(monthIndex > 11)
        {
            monthIndex = 0;
            year += 1;
        }
        
        viewDidLoad()
    }
    
    @IBAction func prevPressed(_ sender: AnyObject)
    {
        monthIndex -= 1
        if(monthIndex < 0)
        {
            monthIndex = 11
            year -= 1
        }
        
        viewDidLoad()
    }
    
    
    
    
}

