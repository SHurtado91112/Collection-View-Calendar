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
    
    let currDate = Date()
    let dateFormatter: DateFormatter = DateFormatter()

    var month: Int = 0
    var year: Int = 0
    
    let daysPerWeek: Int = 7
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
            
            initialLoad = false
        }
        
        let unitFlags = Set<Calendar.Component>([.day, .month, .year])
        
        let components = Calendar.current.dateComponents(unitFlags, from: currDate)
        dateFormatter.dateStyle = .short
        month = components.month!
        year = components.year!
        
        monthIndex = month - 1
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
        var rows = Int(ceil(CGFloat(daysPerMonth[monthIndex].days)/CGFloat(daysPerWeek)))
        print("\n\nSECTIONS \(rows)\n\n\n")
        rows = 0
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell:CellView=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellView;
        cell.backgroundColor = backColor;
//        if(indexPath.row )
//        {
//            
//        }
        
        cell.dayLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    
}

