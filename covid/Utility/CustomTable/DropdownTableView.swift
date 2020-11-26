//
//  DropdownTableView.swift
//  covid
//
//  Created by venkata baisani on 21/11/20.
//

import UIKit
protocol DropdownTableViewDelegate: NSObjectProtocol {
    func didSelectBtn(relationVal: String)
}

class DropdownTableView: UIView {
    let kCONTENT_XIB_NAME = "DropdownTableView"
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet weak var btnAgeTrue: UIButton!
    @IBOutlet weak var btnAgefalse: UIButton!
    
    var selectionAge:String? = ""
    
    weak var delegate: DropdownTableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        let viewForXib = Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)![0] as! UIView
        viewForXib.frame = self.bounds
        addSubview(viewForXib)
    }
    
    @IBAction func reloationshipBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 100 {
            
            selectionAge = "Yes"
            btnAgefalse.isSelected = false
            btnAgeTrue.isSelected = true
            
        } else if selBtn.tag == 101 {
            
            selectionAge = "No"
            btnAgeTrue.isSelected = false
            btnAgefalse.isSelected = true
        }
        
        self.delegate?.didSelectBtn(relationVal: selectionAge ?? "")
    }
}

