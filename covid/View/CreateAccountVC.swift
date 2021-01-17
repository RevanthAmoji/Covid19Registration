//
//  CreateAccountVC.swift
//  covid
//
//  Created by venkata baisani on 06/12/20.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Intialize view model variable
    var viewModel = EmailAddressViewModel()

    @IBOutlet weak var emailTF: SutherlandTextField!
    @IBOutlet weak var reenterEmailTF: SutherlandTextField!
    
    @IBOutlet weak var passwordTF: SutherlandTextField!
    @IBOutlet weak var rePasswordTF: SutherlandTextField!
    
    @IBOutlet weak var firstnameTF: SutherlandTextField!
    @IBOutlet weak var lastNameTF: SutherlandTextField!
    
    @IBOutlet weak var nextBtn: SutherlandButton!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!

    @IBOutlet weak var lblFirstNameError,lblLastNameError,lblEmailError,lblReenterEmailError,lblPasswordError,lblReenterPasswordError: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

       // nextBtn.btnEnable(boolVal: false)

       SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        passwordTF.textContentType = .oneTimeCode
        rePasswordTF.textContentType = .oneTimeCode

        emailTF.text = SingletonData.shared.email
        reenterEmailTF.text = SingletonData.shared.email
      
    }
    
    func checkAllTheFeilds() {
        //tfIdentification.text
      //  nextBtn.btnEnable(boolVal: false)
        
        if emailTF.text?.count == 0 || emailTF == nil {
            lblEmailError.text = "Please enter email address"
        }
        if reenterEmailTF.text?.count == 0 || reenterEmailTF == nil {
            lblReenterEmailError.text = "Please enter re-email address"
        }
        if passwordTF.text?.count == 0 || passwordTF == nil {
            lblPasswordError.text = "Please enter password"
        }
        if rePasswordTF.text?.count == 0 || rePasswordTF == nil {
            lblReenterPasswordError.text = "Please enter re-enter password"
        }
        if firstnameTF.text?.count == 0 || firstnameTF == nil {
            lblFirstNameError.text = "Please enter first name"
        }
        if lastNameTF.text?.count == 0 || lastNameTF == nil {
            lblLastNameError.text = "Please enter last name"
        }
        
        if !viewModel.validateEmailAddress(email: emailTF.text ?? "") {
            lblEmailError.text = "Enter Valid E-mail"
        }
        if !viewModel.validateEmailAddress(email: reenterEmailTF.text ?? "") {
            lblReenterEmailError.text = "Enter Valid E-mail"
        }
        
        if emailTF.text != reenterEmailTF.text {
            lblReenterEmailError.text = "Email doesn't match"
        }
        if passwordTF.text != rePasswordTF.text {
            lblReenterPasswordError.text = "Password doesn't match"
        }
        
        if emailTF.text?.count != 0 && reenterEmailTF.text?.count != 0 && passwordTF.text?.count != 0 && rePasswordTF.text?.count != 0 && firstnameTF.text?.count != 0 && lastNameTF.text?.count != 0 && viewModel.validateEmailAddress(email: emailTF.text ?? "") && viewModel.validateEmailAddress(email: reenterEmailTF.text ?? "") && (emailTF.text == reenterEmailTF.text) && (passwordTF.text == rePasswordTF.text) {
            
            checkConnectivity()

        }
    }
    
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
      
            SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
        // Add this observers to observe keyboard shown and hidden events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  Remove the observers added for keyboard from your ViewController
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self, name: UIWindow.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillBeHidden (aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        self.scrollViewReg.contentInset = contentInsets
        self.scrollViewReg.scrollIndicatorInsets = contentInsets
        self.scrollViewReg.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    // Called when the UIKeyboardWillShow is sent
    // This method will adjust your scrollView and will show textFields above the keyboard.
    @objc func keyboardWillShow(aNotification: NSNotification) {
        let userInfo: NSDictionary = aNotification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 50, right: 0)
        self.scrollViewReg.contentInset = contentInsets
        self.scrollViewReg.scrollIndicatorInsets = contentInsets
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = emailTF.text ?? ""
            let dic = "{\"EmailAddress\":\"\(emailTF.text ?? "")\",\"PatientFirstName\":\"\(firstnameTF.text ?? "")\",\"PatientLastName\":\"\(lastNameTF.text ?? "")\",\"Password\":\"\(passwordTF.text ?? "")\"}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.values
            print("email verification: \(authUrl as Any)")
            SingletonData.shared.email = email
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        
                        UserData.shared.setIsUserLogin(boolVal: true)
                        UserData.shared.setUserDetails(UserName: self.emailTF.text ?? "", password: self.passwordTF.text ?? "")
                        
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "VerifiedViewController") as! VerifiedViewController
                            self.navigationController?.pushViewController(controller, animated: false)
                        
                    } else {
                        self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                        
                    }
                    
                case .failure( _):
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
            self.showOfflineMessage(title: "Network Error", msg: "Unable to access the Network")
       }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        SingletonData.shared.createAccountFirstname = firstnameTF.text ?? ""
        SingletonData.shared.createAccountLastname = lastNameTF.text ?? ""
        
        
        checkAllTheFeilds()
        
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

}
extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTF {
            
            passwordTF.isSecureTextEntry = true
           
        } else if textField == rePasswordTF {
            
            rePasswordTF.isSecureTextEntry = true
        }
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        /*
        if textField == emailTF {
             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
            emailTF.showBoaderColor(isEnable: !isValid)
        }
        else if textField == reenterEmailTF {
             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
            reenterEmailTF.showBoaderColor(isEnable: !isValid)
            if isValid  && emailTF.text == reenterEmailTF.text {
                emailTF.showBoaderColor(isEnable: false)
                reenterEmailTF.showBoaderColor(isEnable: false)
            } else {
                emailTF.showBoaderColor(isEnable: true)
                reenterEmailTF.showBoaderColor(isEnable: true)
            }
        } else if textField == passwordTF {
            
            if passwordTF.text?.count == 0 {
                passwordTF.showBoaderColor(isEnable: true)
            } else {
                passwordTF.showBoaderColor(isEnable: false)
            }
        } else if textField == rePasswordTF {
            
            if passwordTF.text == rePasswordTF.text {
                passwordTF.showBoaderColor(isEnable: false)
                rePasswordTF.showBoaderColor(isEnable: false)
            } else {
                passwordTF.showBoaderColor(isEnable: true)
                rePasswordTF.showBoaderColor(isEnable: true)
            }
        }
        checkAllTheFeilds()
 */
    }
  
    
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.location == 0 && string == " " {
            return false
        }
        if !string.canBeConverted(to: .ascii){
            return false
        }
        
        var text = textField.text ?? ""
        
        if string.count == 0 && text.count > 0 {
            text.removeLast()
        } else {
            text += string
        }
        
        if textField == firstnameTF {
           
            if text.count > 0 {
                lblFirstNameError.text = ""
            }
            
        }
        
        if textField == lastNameTF {
           
            if text.count > 0 {
                lblLastNameError.text = ""
            }
            
        }
        /*
        if textField == passwordTF {
           
            if text.count > 0 {
                lblPasswordError.text = ""
            }
            
        }
        
        if textField == emailTF {
            let isValid = viewModel.validateEmailAddress(email: text )
            lblEmailError.text = ""
            if !isValid {
                lblEmailError.text = "Enter Valid Email"
            }
        } else if textField == reenterEmailTF {
            let isValid = viewModel.validateEmailAddress(email: text )
            lblReenterEmailError.text = ""
            if !isValid {
                lblReenterEmailError.text = "Enter Valid Email"
            }
            if isValid {
                lblReenterEmailError.text = ""
                if emailTF.text != text {
                    lblReenterEmailError.text = "Email not match"
                }
                if emailTF.text == text {
                    lblReenterEmailError.text = ""
                }
            }
        } else if textField == rePasswordTF{
           
          
            if passwordTF.text != text {
                lblReenterPasswordError.text = "Email not match"
            }
            if passwordTF.text == text {
                lblReenterPasswordError.text = ""
            }
           
        }
        */
       // print(text)
       
      return true
    }
    
}
