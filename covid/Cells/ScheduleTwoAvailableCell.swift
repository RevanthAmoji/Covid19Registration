//
//  ScheduleTwoAvailableCell.swift
//  covid
//
//  Created by venkata baisani on 08/12/20.
//

import UIKit

class ScheduleTwoAvailableCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: SutherlandLabel!
    @IBOutlet weak var subTitlelbl: SutherlandLabel!
    
    @IBOutlet weak var backGndView: UIView!
    
    @IBOutlet weak var tickImage: UIImageView!

    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
