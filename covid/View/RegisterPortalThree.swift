//
//  RegisterPortalThree.swift
//  covid
//
//  Created by venkata baisani on 14/12/20.
//

import UIKit

class RegisterPortalThree: UIViewController {
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var btnSelAgree:UIButton!
    
    var selAgreeStr:String? = "No"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        btnSelAgree.isSelected = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSelAgreeAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.isSelected {
            selAgreeStr = "No"
            btnSelAgree.isSelected = false
        } else {
            selAgreeStr = "Yes"
            btnSelAgree.isSelected = true
        }
    }
}
