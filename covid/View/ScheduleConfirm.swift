//
//  ScheduleConfirm.swift
//  covid
//
//  Created by venkata baisani on 15/12/20.
//

import UIKit

class ScheduleConfirm: UIViewController {
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var btnEditOne,btnEditTwo,btnEditThree:UIButton!
    
    @IBOutlet weak var lblClientName,lblClientAddress,lblTestDate,lblTestTime:SutherlandLabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPreviousData()
    }
    

    func setPreviousData(){
        lblClientName.text = SingletonData.shared.clientName
        lblClientAddress.text = SingletonData.shared.clientAddress
        lblTestDate.text = SingletonData.shared.testDate
        lblTestTime.text = SingletonData.shared.testTime
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
