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
    @IBOutlet weak var nextBtn: SutherlandButton!

   

    override func viewDidLoad() {
        super.viewDidLoad()

        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
        nextBtn.btnEnable(boolVal: false)
    
    }
    
    func checkConnectivity() {
        
      //  self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
            let email = emailTF.text ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\"}'}"
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
                        self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                        
                    }
                    
                case .failure( _):
                   // self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
         //   self.hideProgressBar()
            self.showOfflineMessage(title: "Network Error", msg: "Unable to access the Network")
       }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        SingletonData.shared.email = emailTF.text
        checkConnectivity()
        
    }
    
    func showOfflineMessage(title: String, msg: String) {
       
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
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
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

extension EmailAddressVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTF {
             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
            emailTF.showBoaderColor(isEnable: !isValid)
        }
        else if textField == reenterEmailTF {
             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
            reenterEmailTF.showBoaderColor(isEnable: !isValid)
            if isValid  && emailTF.text == reenterEmailTF.text {
                nextBtn.btnEnable(boolVal: true)
                emailTF.showBoaderColor(isEnable: false)
                reenterEmailTF.showBoaderColor(isEnable: false)
            } else {
                emailTF.showBoaderColor(isEnable: true)
                reenterEmailTF.showBoaderColor(isEnable: true)
            }
        }
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
      return true
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
