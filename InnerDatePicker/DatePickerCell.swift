//
//  DatePickerCell.swift
//  InnerDatePicker
//
//  Created by Chisato Matsuzaki on 2018/09/17.
//  Copyright © 2018年 EnchantedWorks. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}