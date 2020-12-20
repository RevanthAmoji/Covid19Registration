//
//  ScheduleConfirm.swift
//  covid
//
//  Created by venkata baisani on 15/12/20.
//

import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
class ScheduleConfirm: UIViewController {
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var btnEditOne,btnEditTwo,btnEditThree:UIButton!
    
    @IBOutlet weak var lblClientName,lblClientAddress,lblTestDate,lblTestTime:SutherlandLabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setPreviousData()
    }
    
    @IBAction func edit(_ sender: UIButton) {
        let button = sender
        if button.tag == 1 {
            navigationController?.popToViewController(ofClass: ScheduleScreenOne.self)
        } else if button.tag == 2 {
            navigationController?.popToViewController(ofClass: ScheduleScreentwo.self)
        } else if button.tag == 2 {
            navigationController?.popToViewController(ofClass: ScheduleScreentwo.self)
        }
    }
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        checkConnectivity()
    }

    func setPreviousData(){
        lblClientName.text = SingletonData.shared.clientName
        lblClientAddress.text = SingletonData.shared.clientAddress
        lblTestDate.text = SingletonData.shared.testDate
        lblTestTime.text = SingletonData.shared.testTime
    }
    
    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? "rev1@test.com"
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"SlotID\":\"\(SingletonData.shared.slotId ?? "")\",\"FacilityID\":\"\(SingletonData.shared.hospitalID ?? "")\",\"SlotDate\":\"\(SingletonData.shared.testDate ?? "")\"}'}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterPortalOne") as! RegisterPortalOne
                        self.navigationController?.pushViewController(controller, animated: false)
                        
                    } else {
                        self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                    }
                case .failure( _):
                    //something went wrong, print the error.
                    self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                }
            })
        } else {
            self.showsAlertWithoutWhiteBg(titleVal: "Network Error", messageVal: "Unable to access the Network")
        }
    }
    
    func showsAlertWithoutWhiteBg( titleVal : String , messageVal: String) {
        let alertController = UIAlertController(title: titleVal, message: messageVal, preferredStyle: .alert)
        let trueAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(trueAction)
        self.present(alertController, animated: true, completion: nil)
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
