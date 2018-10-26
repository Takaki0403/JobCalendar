//
//  CalendarWeekCell.swift
//  JobCalendar
//
//  Created by Takaki Otsu on 2018/10/26.
//  Copyright © 2018年 Takaki Otsu. All rights reserved.
//

import UIKit

class CalendarWeekCell: UICollectionViewCell {

    @IBOutlet weak var weekLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(week: String) {
        self.weekLabel.text = week
        self.backgroundColor = .lightGray
    }

}
