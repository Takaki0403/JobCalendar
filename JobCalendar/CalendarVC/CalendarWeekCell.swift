//
//  CalendarWeekCell.swift
//  JobCalendar
//
//  Created by Takaki Otsu on 2018/10/26.
//  Copyright © 2018年 Takaki Otsu. All rights reserved.
//

import UIKit

class CalendarWeekCell: UICollectionViewCell {

    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var weekLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backV.layer.borderColor = UIColor.black.cgColor
//        self.backV.layer.borderWidth = 0.5
    }
    
    func setupCell(week: String) {
        self.weekLabel.text = week
        self.backgroundColor = .lightGray
    }

}
