//
//  MapCollectionViewCell.swift
//  covid
//
//  Created by venkata baisani on 03/12/20.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titlelbl: SutherlandLabel!
    @IBOutlet weak var subTitlelbl: SutherlandLabel!
    @IBOutlet weak var seats: SutherlandLabel!
    
    @IBOutlet weak var backGndView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
