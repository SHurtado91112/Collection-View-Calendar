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
    
    let daysPerWeek: Int = 7
    var currRow: Int = 0
    var monthIndex: Int = 0
    var daysCounter: Int = 0
    var initialLoad = true
    
    var daysPerMonth:[(month: String, days: Int)] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView!.register(CellView.self, forCellWithReuseIdentifier: "cell")
        
        if(initialLoad)
        {
            daysPerMonth.append(("January", 31))
            daysPerMonth.append(("February", 28))
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
            
            let unitFlags = Set<Calendar.Component>([.day, .month, .year])
            
            let components = Calendar.current.dateComponents(unitFlags, from: currDate)
            dateFormatter.dateStyle = .short
            month = components.month!
            year = components.year!
            
            monthIndex = month - 1
            
            initialLoad = false
        }
        
        
        print("\n\n\n\n\n\n\n\(monthIndex)\n\n\n\n\n\n\n")
        
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
        return daysPerMonth[monthIndex].days
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
        if(currRow > 7)
        {
            currRow = 1;
        }
        
        if(currRow == 1 || currRow == 7)
        {
            cell.backgroundColor = txtColor;
        }
        else
        {
            cell.backgroundColor = backColor;
        }
        
        cell.dayLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    
    @IBAction func nextPressed(_ sender: AnyObject)
    {
        monthIndex += 1;
        if(monthIndex > 11)
        {
            monthIndex = 0;
            year += 1;
        }
        
        viewDidLoad();
    }
    
    @IBAction func prevPressed(_ sender: AnyObject)
    {
        monthIndex -= 1;
        if(monthIndex < 0)
        {
            monthIndex = 11;
            year -= 1;
        }
        viewDidLoad();
    }
    
    
    
    
}

