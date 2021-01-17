//
//  VerificationCodeViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class VerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var tf1: SutherlandTextField!
    @IBOutlet weak var tf2: SutherlandTextField!
    @IBOutlet weak var tf3: SutherlandTextField!
    @IBOutlet weak var tf4: SutherlandTextField!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.btnEnable(boolVal: true)
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
       
        let code = "\(tf1.text ?? "")\(tf2.text ?? "")\(tf3.text ?? "")\(tf4.text ?? "")"
        
        if SingletonData.shared.verificationCode == code {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FinalViewController") as! FinalViewController
            self.navigationController?.pushViewController(controller, animated: false)
        } else {
            self.showOfflineMessage(title: "Not matched", msg: "Please verify once again")
        }
        
    }
    
    
    func checkConnectivityEmail() {
        
      // self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\"}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account+"?VerifyEmailAddress=\(email)"
            print("email verification: \(authUrl as Any)")
            SingletonData.shared.email = email
            Services.getDashboardService().getEmailVerification(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                
                case .success( _):
                 // self.hideProgressBar()
                  break
                    
                case .failure( _):
                   // self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
           // self.hideProgressBar()
            self.showOfflineMessage(title: "Network Error", msg: "Unable to access the Network")
       }
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
    
    @IBAction func verifiedPhone(_ sender: Any) {
        
        checkConnectivity()
        checkConnectivityEmail()
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

extension VerificationCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField.text!.count < 1 && string.count > 0 {
            let tag = textField.tag + 1;
            let nextResponder = textField.superview?.viewWithTag(tag)

            if (nextResponder != nil){
                textField.resignFirstResponder()

            }
           
            
            textField.text = string;
            if (nextResponder == nil){
                textField.resignFirstResponder()
                return true
            }
            if (nextResponder != nil){
                nextResponder?.becomeFirstResponder()

            }
            return false;


        }else if (textField.text?.count)! >= 1 && string.count == 0 {
            let prevTag = textField.tag - 1
            let prevResponser = textField.superview?.viewWithTag(prevTag)
              if (prevResponser != nil){
                textField.resignFirstResponder()
            }
            textField.text = string
            if (prevResponser != nil){
                prevResponser?.becomeFirstResponder()

            }
             return false
        }

      return true
    }
    
}
