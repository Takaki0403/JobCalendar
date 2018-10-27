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
    }
    
    func setupCell(week: String, indexPath: IndexPath, daysOfPreMonth: Int, daysOfLastMonth: Int) {
        self.weekLabel.text = week
        if (indexPath.row % 7 == 0) {
            self.weekLabel.textColor = UIColor.red
        } else if (indexPath.row % 7 == 6) {
            self.weekLabel.textColor = UIColor.blue
        } else {
            self.weekLabel.textColor = UIColor.black
        }
    }

}
