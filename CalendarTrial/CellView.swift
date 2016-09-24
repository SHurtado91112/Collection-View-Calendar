//
//  CellView.swift
//  CalendarTrial
//
//  Created by Steven Hurtado on 9/16/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class CellView: UICollectionViewCell
{
    var dayLabel: UILabel!
    
    var viewHolder: UIView!
    
    let txtColor = UIColor(red: (134/255.0), green: (144/255.0), blue: (255/255.0), alpha: 1)
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        viewHolder = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        
        dayLabel = UILabel(frame:  CGRect(x: 0, y: viewHolder.frame.size.height, width: frame.size.width, height: frame.size.height/3))
       
        viewHolder.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(viewHolder)
       
        dayLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize,weight: UIFontWeightLight)
        dayLabel.textColor = txtColor
        dayLabel.textAlignment = .center
        contentView.addSubview(dayLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
