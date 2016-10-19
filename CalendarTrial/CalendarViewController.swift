//
//  CalendarViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 10/18/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    //
    //          VARIABLE INITIALIZATION
    //
    
    
    var marrClientData : NSMutableArray!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var calendarView: UICollectionView!
    
    
    //USER DEFAULTS
    let def = UserDefaults.standard
    var defArray         = [Int]()
    var defDate          = [String]()
    var validCellArray   = [Int]()
    
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
    
    var dateArray:[(day: Int, month: Int, year: Int)] = []
    
    //
    //  VIEW DID LOAD
    //
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.getClientData()
    }
    
    func getClientData()
    {
        marrClientData = NSMutableArray()
        marrClientData = ModelManager.getInstance().getAllClientData()
        calendarView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        //background gradient///////////
        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 0.5)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 0.9)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        ///////////////////////////////
        
        
        
        dateArray = def.object(forKey: "dateArray") as? [(Int, Int, Int)] ?? [(Int, Int, Int)]()
        
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
    
    
    
    
    //
    //      COLLECTION VIEW
    //
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
//        let dPM = daysPerMonth[monthIndex].days
        let rows = 6//ceil((Double)(firstDayOfWeek+dPM)/7)
        let blocks = rows*7
        
//      marrClientData.count

        
        return Int(blocks)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:CellView=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellView
        
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
            cell.backgroundColor = txtColor
        }
        else
        {
            cell.backgroundColor = backColor
        }
      
        if(!firstWeekShift)
        {
            cell.dayLabel.text = String(indexPath.row + 1 - firstDayOfWeek)
            cell.day = indexPath.row + 1 - firstDayOfWeek
            cell.month = month
            cell.year = year
            
            if(indexPath.row + 1 - firstDayOfWeek > daysPerMonth[monthIndex].days || indexPath.row + 1 - firstDayOfWeek <= 0)
            {
                cell.dayLabel.text = ""
            }
            else
            {
                //search for date associated
                if(marrClientData.count > 0)
                {
                    for i in (0...marrClientData.count-1)
                    {
                        let client:ClientInfo = marrClientData.object(at: i) as! ClientInfo
                        defArray = def.object(forKey: "\(client.Name) Index") as? [Int] ?? [Int]()
                        defDate  = def.object(forKey: "\(client.Name) Date") as? [String] ?? [String]()
                        
                        if(defDate.count > 0)
                        {
                            for i2 in (0...defDate.count-1)
                            {
                                var tempDate = defDate[i2]
                                
                                let parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 10)
                                
                                tempDate = tempDate.substring(to: parseIndex)
                                
                                var dayString = String(cell.day)
                                if(dayString.characters.count == 1)
                                {
                                    dayString = "0\(dayString)"
                                }
                                
                                if(tempDate == "\(cell.month!)/\(dayString)/\(cell.year!)")
                                {
                                    cell.backgroundColor = UIColor.cyan
                                    validCellArray.append(indexPath.row)
                                    return cell
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let cell:CellView=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellView;
        
        if(validCellArray.count > 0)
        {
            for i in (0...validCellArray.count-1)
            {
                if(indexPath.row == validCellArray[i])
                {
                    self.performSegue(withIdentifier: "appSegue", sender: cell)
                    return
                }
            }
        }
    }
    
    //
    //      UIBUTTON ACTIONS
    //
    
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "appSegue")
        {
            let item : CellView = sender as! CellView
            
            let viewController : AppointmentViewController = segue.destination as! AppointmentViewController
            viewController.marrClientData = self.marrClientData
            
            viewController.month = item.month
            viewController.day = item.day
            viewController.year = item.year
        }
    }
    
    
    
}

