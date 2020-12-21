//
//  ConfirmScreeningVC.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class ConfirmScreeningVC: UIViewController {

    
    @IBOutlet weak var lblClientName:UILabel!
    @IBOutlet weak var lblClientAddress:UILabel!
    @IBOutlet weak var lblTestDate:UILabel!
    @IBOutlet weak var lblTestTime:UILabel!
    
    var availableSlots:MyScheduleTests?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPreviousData()
    }
    
    func setPreviousData() {
        
        lblClientName.text = availableSlots?.ClinicName
        lblClientAddress.text = availableSlots?.ClinicAddress
        lblTestDate.text = availableSlots?.TestDate
        lblTestTime.text = availableSlots?.TestTime
        
    }
    
    @IBAction func btnGetDirectionsAction(_ sender: Any) {
        self.getDirections()
    }
    func getDirections() {
        let directionsURL = "http://maps.apple.com/?saddr=\(availableSlots?.Latidude ?? ""),\(availableSlots?.Logitude ?? "")"
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
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
