//
//  VerifiedViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class VerifiedViewController: UIViewController, ProgressBarShower{
    
    @IBOutlet weak var btnVerifiedEmail: SutherlandButton!
    @IBOutlet weak var btnVerifiedPassword: SutherlandButton!
    @IBOutlet weak var btnTwoStepsVerification: SutherlandButton!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnVerifiedEmail.btnEnableNew(boolVal: true)
        btnVerifiedPassword.btnEnableNew(boolVal: true)
        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func checkConnectivity() {
        
        self.showProgressBar()
        
        if Reachability.isConnectedToNetwork() {
    
            let email = "revanth.amojinarsimha@sutherlandglobal.com"
           // let email = SingletonData.shared.email
            let username = "\(SingletonData.shared.createAccountFirstname ?? "first")%20\(SingletonData.shared.createAccountLastname ?? "last")"
            let authUrl = Endpoint.validEmail+(email)+Endpoint.userName+username //"https://covid19api.sutherlandglobal.com/api/Scheduling?MailID=revanth.amojinarsimha@sutherlandglobal.com&username=abc bbc"
            print("verified verification: \(authUrl as Any)")
            Services.getDashboardService().getVerifiedData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if let verified = dashboads as? String {
                        print(dashboads)
                        SingletonData.shared.verificationCode = verified
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "VerificationCodeViewController") as! VerificationCodeViewController
                        self.navigationController?.pushViewController(controller, animated: false)
                    } else {
                        self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                    }
                    
                case .failure( _):
                    self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
            self.hideProgressBar()
            self.showOfflineMessage(title: "Network Error", msg: "Unable to access the Network")
       }
    }
    
    @IBAction func verifiedEmail(_ sender: Any) {
        
        checkConnectivity()
        
    }
    
    func showOfflineMessage(title: String, msg: String) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
           
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { _ in
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
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
