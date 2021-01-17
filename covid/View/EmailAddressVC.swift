//
//  EmailAddressVC.swift
//  covid
//
//  Created by venkata baisani on 18/11/20.
//

import UIKit
import NVActivityIndicatorView

class EmailAddressVC: UIViewController,ProgressBarShower{
    
    // Intialize view model variable
    var viewModel = EmailAddressViewModel()
    
    // Initialize email textField variable
    @IBOutlet weak var emailTF: SutherlandTextField!
    @IBOutlet weak var reenterEmailTF: SutherlandTextField!
    @IBOutlet weak var mobileTF: SutherlandTextField!
    @IBOutlet weak var nextBtn: SutherlandButton!
   // @IBOutlet weak var previousBtn: SutherlandButton!
    
    @IBOutlet weak var textViewAlert: UITextView!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    let linkUrl = "www.sutherland.com"

    var preferredModeOfComm:String? =  ""
    
    @IBOutlet weak var btnEmailTrue: UIButton!
    @IBOutlet weak var btnEmailfalse: UIButton!
    
    @IBOutlet weak var lblemailerror, lblReemailerror, lblphonenumbererror, lblmodeofcommerror:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
        nextBtn.btnEnableNew(boolVal: true)
      //  previousBtn.btnEnableNew(boolVal: true)
        
        SingletonData.shared.isFromLogin = false
    
        textViewAlert.isHidden = true
        textViewAlert.hyperLink(originalText: "E-Mail already exists. Click here to Sign In.", hyperLink: "here", urlString: linkUrl)

    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        
      //  emailTF.layer.cornerRadius = emailTF.frame.size.height/2
      //  reenterEmailTF.layer.cornerRadius = reenterEmailTF.frame.size.height/2
      //  nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2
     //   previousBtn.layer.cornerRadius = previousBtn.frame.size.height/2

        self.navigationController?.setNavigationBarHidden(false, animated: true)
       // SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
        // Add this observers to observe keyboard shown and hidden events
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  Remove the observers added for keyboard from your ViewController
        let center: NotificationCenter = NotificationCenter.default
        center.removeObserver(self, name: UIWindow.keyboardDidShowNotification, object: nil)
        center.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillBeHidden (aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
      //  self.scrollViewReg.contentInset = contentInsets
      //  self.scrollViewReg.scrollIndicatorInsets = contentInsets
      //  self.scrollViewReg.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    // Called when the UIKeyboardWillShow is sent
    // This method will adjust your scrollView and will show textFields above the keyboard.
    @objc func keyboardWillShow(aNotification: NSNotification) {
        let userInfo: NSDictionary = aNotification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 50, right: 0)
      //  self.scrollViewReg.contentInset = contentInsets
      //  self.scrollViewReg.scrollIndicatorInsets = contentInsets
    }
    */
    
    @IBAction func reloationshipBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 100 {
            
            preferredModeOfComm = "Email"
            btnEmailfalse.isSelected = false
            btnEmailTrue.isSelected = true
            
        } else if selBtn.tag == 101 {
            
            preferredModeOfComm = "Mobile"
            btnEmailTrue.isSelected = false
            btnEmailfalse.isSelected = true
        }
        
        if preferredModeOfComm?.count == 0 {
            lblmodeofcommerror.text = "Preferred mode of communication is required"
        } else {
            lblmodeofcommerror.text = ""
        }
//        nameViewHeight.constant = 203
//        nameViewHeightView.isHidden = false
        
    }
    
    func checkConnectivityAuthorization() {
        
        self.showProgressBar()
        
        if Reachability.isConnectedToNetwork() {
    
            let email = emailTF.text ?? ""
            let authUrl = Endpoint.authorization+email
            print("verified verification: \(authUrl as Any)")
            Services.getDashboardService().getAutherizationResponse(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                 //   if let verified = dashboads as? Bool {
                        if dashboads {
                            self.hideProgressBar()
                            DispatchQueue.main.async {
                                self.textViewAlert.isHidden = false
                            }
                        } else {
                            self.checkConnectivity()
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
    
   
    
    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = emailTF.text ?? ""
            let mobileNumber = mobileTF.text ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"MobileNumber\":\"\(mobileNumber)\",\"PreferredModeOfComm\":\"\(preferredModeOfComm ?? "")\"}'}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            SingletonData.shared.email = email
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                
                case .success(let dashboads):
                  // self.hideProgressBar()
                    if dashboads.isSuccess ?? false {
                        
                        self.checkConnectivityBackUpData()
                        
                    } else {
                        self.hideProgressBar()
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
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        SingletonData.shared.email = emailTF.text
        checkAllFields()
        
    }
    
    func checkAllFields() {
        
        lblReemailerror.text = ""
        lblphonenumbererror.text = ""
        lblemailerror.text = ""
        lblmodeofcommerror.text = ""
        
       
        if preferredModeOfComm?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            lblmodeofcommerror.text = "Preferred mode of communication is required"
        }
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            lblemailerror.text = "E-Mail is required"
        } else if !viewModel.validateEmailAddress(email: emailTF.text ?? "") {
            lblemailerror.text = "Enter Valid E-mail"
        }
        if reenterEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            lblReemailerror.text = "E-Mail is required"
        } else if !viewModel.validateEmailAddress(email: reenterEmailTF.text ?? "") {
            lblReemailerror.text = "Enter Valid E-mail"
        } else if emailTF.text != reenterEmailTF.text {
            lblReemailerror.text = "Email doesn't match"
        }
        
        if mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            lblphonenumbererror.text = "Mobile Number is required"
        } else if !viewModel.validatePhoneNumber(phone: mobileTF.text ?? "") {
            lblphonenumbererror.text = "Enter Valid Mobile Number"
        }
        
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && reenterEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && preferredModeOfComm?.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && viewModel.validateEmailAddress(email: emailTF.text ?? "") && viewModel.validateEmailAddress(email: reenterEmailTF.text ?? "") && viewModel.validatePhoneNumber(phone: mobileTF.text ?? "") && (emailTF.text == reenterEmailTF.text) {
            
            checkConnectivityAuthorization()
            
        }
    }
    
    @IBAction func previousBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  
    func showOfflineMessage(title: String, msg: String) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            self.navigationController?.pushViewController(controller, animated: false)
        }
      
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showOfflineMessageForExitUser(title: String, msg: String) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
           
        }
      
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkConnectivityBackUpData() {
        
        if Reachability.isConnectedToNetwork() {
            
            // let authUrl = Endpoint.accountDetails+"s.shetty@gmail.com"
            let authUrl = Endpoint.accountPreviousData+(SingletonData.shared.email ?? "")
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getPreviousData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    SingletonData.shared.StatusCode = dashboads.StatusCode
                    if dashboads.StatusCode == 0 {
                    
                        let data = dashboads.Data?[0]
                        SingletonData.shared.firstNamePatient = data?.PatientFirstName
                        SingletonData.shared.lastNamePatient = data?.PatientLastName
                        SingletonData.shared.email = data?.EmailAddress
                        SingletonData.shared.patientAge = data?.PatientAge?.convertedValue
                        SingletonData.shared.relationNumber = data?.PatientRelationshipVal
                        SingletonData.shared.relationName = data?.PatientRelationshipText
                        SingletonData.shared.guardianFullName = data?.GuardianFullName
                        SingletonData.shared.consent = data?.PatientConsent?.convertedValue
                        SingletonData.shared.symptoms = data?.HasCoronasymptoms?.convertedValue
                        SingletonData.shared.dateSymptomsStarted = data?.SymptomsStartedDate
                        SingletonData.shared.proritizedForTesting = data?.ProritizedTesting?.convertedValue
                        SingletonData.shared.firstTimeTesting = data?.IsFirstTimeTest?.convertedValue
                        SingletonData.shared.contactWithAnyOne = data?.ContactedLast15days?.convertedValue
                        SingletonData.shared.medicalCondition = data?.MedicalCondition?.convertedValue
                        SingletonData.shared.pregnant = data?.IsPregnant?.convertedValue
                        SingletonData.shared.highRiskCategory = data?.IsHighriskCategory?.convertedValue
                        SingletonData.shared.smoker = data?.IsSmoke?.convertedValue
                        
                        SingletonData.shared.primaryCareProvider = data?.hasPrimarycareProv?.convertedValue
                        SingletonData.shared.careProvider = data?.PrimaryCareName
                        SingletonData.shared.addressLineOne = data?.PrimaryCareAddLine1
                        SingletonData.shared.addressLineTwo = data?.PrimaryCareAddLine2
                        SingletonData.shared.city = data?.PrimaryCareCity
                        SingletonData.shared.state = data?.PrimaryCareState
                        SingletonData.shared.zipCode = data?.PrimaryCareZipcode
                        SingletonData.shared.phoneNumber = data?.PrimaryCarePhone
                       // SingletonData.shared.email = data?.PrimaryCareEmail
                        SingletonData.shared.careFacility = data?.hasCareFacility?.convertedValue
                        
                        SingletonData.shared.dateOfBirth = data?.PatientDOB
                        SingletonData.shared.gender = data?.PatientGenderText
                        SingletonData.shared.genderVal = data?.PatientGenderVal
                        SingletonData.shared.race = data?.PatientEthnicityText
                        SingletonData.shared.raceVal = data?.PatientEthnicityVal
                        
                        SingletonData.shared.addressLineOnePatient = data?.PatientAddLine1
                        SingletonData.shared.addressLineTwoPatient = data?.PatientAddLine2
                        SingletonData.shared.cityPatient = data?.PatientCity
                        SingletonData.shared.statePatient = data?.PatientState
                        SingletonData.shared.zipCodePatient = data?.PatientZipcode
                        SingletonData.shared.insuranceProvider = data?.PatientInsuranceName
                        SingletonData.shared.policyNumber = data?.PatientPolicyno
                        SingletonData.shared.policyHolderName = data?.PatientPolicyholderName
                        SingletonData.shared.identification = data?.PatienthasvalididentificationText
                        SingletonData.shared.identificationVal = data?.PatienthasvalididentificationVal
                        
                    }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
                        self.navigationController?.pushViewController(controller, animated: false)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmailAddressVC: UITextFieldDelegate,UITextViewDelegate {
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) ->  Bool {

        if emailTF.isFirstResponder {
            DispatchQueue.main.async(execute: {
                (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
            })
            return false
        }
        if reenterEmailTF.isFirstResponder {
            DispatchQueue.main.async(execute: {
                (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
            })
            return false
        }
        if mobileTF.isFirstResponder {
            DispatchQueue.main.async(execute: {
                (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
            })
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == emailTF {
//             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
//            emailTF.showBoaderColor(isEnable: !isValid)
//        }
//        else if textField == reenterEmailTF {
//             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
//            reenterEmailTF.showBoaderColor(isEnable: !isValid)
//            if isValid  && emailTF.text == reenterEmailTF.text {
//                nextBtn.btnEnableNew(boolVal: true)
//                emailTF.showBoaderColor(isEnable: false)
//                reenterEmailTF.showBoaderColor(isEnable: false)
//            } else {
//                emailTF.showBoaderColor(isEnable: true)
//                reenterEmailTF.showBoaderColor(isEnable: true)
//            }
//        }
//        if textField == reenterEmailTF {
//
//                lblReemailerror.text = ""
//                if emailTF.text != reenterEmailTF.text {
//                    lblReemailerror.text = "Email not match"
//                }
//                if emailTF.text == reenterEmailTF.text {
//                    lblReemailerror.text = ""
//                }
//
//        }
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
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")

        if (isBackSpace == -92) {
            print("Backspace was pressed")
        }
        /*
        if textField == emailTF {
            let isValid = viewModel.validateEmailAddress(email: text )
            lblemailerror.text = ""
            if !isValid {
                lblemailerror.text = "Enter Valid Email"
            }
        } else if textField == reenterEmailTF {
            let isValid = viewModel.validateEmailAddress(email: text )
            lblReemailerror.text = ""
            if !isValid {
                lblReemailerror.text = "Enter Valid Email"
            }
            if isValid {
                lblReemailerror.text = ""
                if emailTF.text != text {
                    lblReemailerror.text = "Email not match"
                }
                if emailTF.text == text {
                    lblReemailerror.text = ""
                }
            }
            return false
        } else
 */
        if textField == mobileTF{
           
            textField.text = formatPhone(text)
//            let isValid = viewModel.validatePhoneNumber(phone: textField.text ?? "")
//            lblphonenumbererror.text = ""
//            if !isValid {
//                lblphonenumbererror.text = "Enter Valid phonenumber"
//            }
           return false
        }
        
       // print(text)
       
      return true
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL.absoluteString == linkUrl) {
//            UIApplication.shared.open(URL) { (Bool) in
//
//            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(controller, animated: false)
        }
        return false
    }
    
    func formatPhone(_ number: String) -> String {
        let cleanNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let format: [Character] = ["X", "X", "X", "-", "X", "X", "X", "-", "X", "X", "X", "X"]

        var result = ""
        var index = cleanNumber.startIndex
        for ch in format {
            if index == cleanNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension String {
    var convertedValue: String? {
        switch self.lowercased() {
        case "yes":
            return "1"
        case "no":
            return "0"
        default:
            return nil
        }
    }
}

//extension UITextField {
//    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return action == #selector(UIResponderStandardEditActions.paste(_:)) ?
//            false : super.canPerformAction(action, withSender: sender)
//    }
//}
