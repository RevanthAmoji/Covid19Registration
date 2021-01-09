//
//  RegisterScreenThree.swift
//  covid
//
//  Created by venkata baisani on 24/11/20.
//

import UIKit

class RegisterScreenThree: UIViewController {
    
    // Intialize view model variable
    var viewModel = RegisterScreenThreeModel()
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var btnPrimaryCareProviderTrue: UIButton!
    @IBOutlet weak var btnPrimaryCareProviderfalse: UIButton!
   
    @IBOutlet weak var btnCareFacilityTrue: UIButton!
    @IBOutlet weak var btnCareFacilityfalse: UIButton!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var fieldsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backGndView: UIView!
    
    @IBOutlet weak var tfCareProvider: SutherlandTextField!
    @IBOutlet weak var tfAddressLineOne: SutherlandTextField!
    @IBOutlet weak var tfAddressLineTwo: SutherlandTextField!
    @IBOutlet weak var tfCity: SutherlandTextField!
    @IBOutlet weak var tfState: SutherlandTextField!
    @IBOutlet weak var tfZipCode: SutherlandTextField!
    @IBOutlet weak var tfPhoneNumber: SutherlandTextField!
    @IBOutlet weak var tfEmailAddress: SutherlandTextField!
    
    @IBOutlet weak var primaryCareProviderTitle:UILabel!
    @IBOutlet weak var careFacilityTitle:UILabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
   

    var primaryCareProvider:String? = ""
    var careFacility:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fieldsViewHeight.constant = 0
        backGndView.isHidden = true
        
      //  btnNext.btnEnable(boolVal: false)
        
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        self.setViewTitles()
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


    func setViewTitles() {
        
        if SingletonData.shared.relationNumber == SingletonData.shared.myselfRelationVal {
            
            self.primaryCareProviderTitle.text = titles.primaryCareProvider_myslef
            self.careFacilityTitle.text = titles.careFacility_myslef
            
        } else {
        
        self.primaryCareProviderTitle.text = titles.primaryCareProvider
        self.careFacilityTitle.text = titles.careFacility
        }
        
        if SingletonData.shared.StatusCode == 0 {
            
            self.primaryCareProvider = SingletonData.shared.primaryCareProvider
            if primaryCareProvider == checkBoxInt.trueVal.rawValue {
                btnPrimaryCareProviderTrue.isSelected = true
            } else  if primaryCareProvider == checkBoxInt.falseVal.rawValue {
                btnPrimaryCareProviderfalse.isSelected = true
            }
            self.careFacility = SingletonData.shared.careFacility
            if careFacility == checkBoxInt.trueVal.rawValue {
                btnCareFacilityTrue.isSelected = true
            } else  if careFacility == checkBoxInt.falseVal.rawValue {
                btnCareFacilityfalse.isSelected = true
            }
            self.tfCareProvider.text = SingletonData.shared.careProvider
            self.tfAddressLineOne.text = SingletonData.shared.addressLineOne
            self.tfAddressLineTwo.text = SingletonData.shared.addressLineTwo
            self.tfCity.text = SingletonData.shared.city
            self.tfState.text = SingletonData.shared.state
            self.tfZipCode.text = SingletonData.shared.zipCode
            self.tfPhoneNumber.text = SingletonData.shared.phoneNumber
            self.tfEmailAddress.text = SingletonData.shared.emailAddress
            btnNext.btnEnable(boolVal: true)
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
    // MARK: - Custom Button Actions
    @IBAction func btnPrimaryCareProviderAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 100 {
            primaryCareProvider = "1"
            btnPrimaryCareProviderfalse.isSelected = false
            btnPrimaryCareProviderTrue.isSelected = true
            fieldsViewHeight.constant = 780
            backGndView.isHidden = false
        } else if selBtn.tag == 101 {
            primaryCareProvider = "0"
            btnPrimaryCareProviderfalse.isSelected = true
            btnPrimaryCareProviderTrue.isSelected = false
            fieldsViewHeight.constant = 0
            backGndView.isHidden = true
        }
        checkAllTheFeilds()
    }
    @IBAction func btnCareFacilityAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 102 {
            careFacility = "1"
            btnCareFacilityfalse.isSelected = false
            btnCareFacilityTrue.isSelected = true
        } else if selBtn.tag == 103 {
            careFacility = "0"
            btnCareFacilityfalse.isSelected = true
            btnCareFacilityTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    
    @IBAction func btnNexgt(_ sender: Any) {
       
        SingletonData.shared.primaryCareProvider = primaryCareProvider
        SingletonData.shared.careFacility = careFacility
        SingletonData.shared.careProvider = tfCareProvider.text
        SingletonData.shared.addressLineOne = tfAddressLineOne.text
        SingletonData.shared.addressLineTwo = tfAddressLineTwo.text
        SingletonData.shared.city = tfCity.text
        SingletonData.shared.state = tfState.text
        SingletonData.shared.zipCode = tfZipCode.text
        SingletonData.shared.phoneNumber = tfPhoneNumber.text
        SingletonData.shared.emailAddress = tfEmailAddress.text
        
        checkConnectivity()
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
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 120, right: 0)
        self.scrollViewReg.contentInset = contentInsets
        self.scrollViewReg.scrollIndicatorInsets = contentInsets
    }
    
    func checkAllTheFeilds() {
      //  btnNext.btnEnable(boolVal: false)
        var errorMessage = ""
        if (primaryCareProvider?.count == 0 || primaryCareProvider == nil) {
           
            errorMessage = "Please select Care Provider"
            
        } else  if (careFacility?.count == 0 || careFacility == nil) {
            
            errorMessage = "Please select Care Facility"
            
        } else {
            
            if primaryCareProvider == "Yes" {
                if tfCareProvider.text?.count == 0 || tfCareProvider == nil {
                   errorMessage = "Please enter patient first name"
               } else if tfAddressLineOne.text?.count == 0 || tfAddressLineOne == nil {
                   errorMessage = "Please enter patient last name"
               } else if tfAddressLineTwo.text?.count == 0 || tfAddressLineTwo == nil {
                   errorMessage = "Please enter patient last name"
               } else if tfCity.text?.count == 0 || tfCity == nil {
                   errorMessage = "Please select consent from the patient to register on their behalf"
               } else if tfState.text?.count == 0 || tfState == nil {
                   errorMessage = "Please enter signature"
               } else if tfZipCode.text?.count == 0 || tfZipCode == nil {
                   errorMessage = "Please enter patient last name"
               } else if tfPhoneNumber.text?.count == 0 || tfPhoneNumber == nil {
                   errorMessage = "Please select consent from the patient to register on their behalf"
               } else if tfEmailAddress.text?.count == 0 || tfEmailAddress == nil {
                   errorMessage = "Please enter signature"
               } else {
                   btnNext.btnEnable(boolVal: true)
                   return
               }
            } else {
            btnNext.btnEnable(boolVal: true)
            return
            }
        }
        //self.showsAlertWithoutWhiteBg(titleVal: "", messageVal: errorMessage)
        print(errorMessage)
    }
    
    func showsAlertWithoutWhiteBg( titleVal : String , messageVal: String) {
        let alertController = UIAlertController(title: titleVal, message: messageVal, preferredStyle: .alert)
        let trueAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(trueAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"hasPrimarycare_Prov\":\"\(primaryCareProvider ?? "")\",\"PrimaryCare_Name\":\"\(tfCareProvider.text ?? "")\",\"PrimaryCare_AddLine1\":\"\(tfAddressLineOne.text?.replacingOccurrences(of: ",", with: "%2C") ?? "")\",\"PrimaryCare_AddLine2\":\"\(tfAddressLineTwo.text?.replacingOccurrences(of: ",", with: "%2C") ?? "")\",\"PrimaryCare_City\":\"\(tfCity.text ?? "")\",\"PrimaryCare_State\":\"\(tfState.text ?? "")\",\"PrimaryCare_Zipcode\":\"\(tfZipCode.text ?? "")\",\"PrimaryCare_Email\":\"\(tfEmailAddress.text ?? "")\",\"PrimaryCare_Phone\":\"\(tfPhoneNumber.text ?? "")\",\"hasCare_Facility\":\"\(careFacility ?? "")\"}'}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterScreenConfirm") as! RegisterScreenConfirm
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
}

extension RegisterScreenThree: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == tfCareProvider  {
            
            if textField.text?.count == 0 {
               tfCareProvider.showBoaderColor(isEnable:true)
            } else {
                tfCareProvider.showBoaderColor(isEnable:false)
            }
        
        } else  if textField == tfAddressLineOne  {
            
            if textField.text?.count == 0 {
                tfAddressLineOne.showBoaderColor(isEnable:true)
            } else {
                tfAddressLineOne.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfAddressLineTwo  {
            
            if textField.text?.count == 0 {
                tfAddressLineTwo.showBoaderColor(isEnable:true)
            } else {
                tfAddressLineTwo.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfCity  {
            
            if textField.text?.count == 0 {
                tfCity.showBoaderColor(isEnable:true)
            } else {
                tfCity.showBoaderColor(isEnable:false)
            }
        
        } else  if textField == tfState  {
            
            if textField.text?.count == 0 {
                tfState.showBoaderColor(isEnable:true)
            } else {
                tfState.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfZipCode  {
            
            if textField.text?.count == 0 {
                tfZipCode.showBoaderColor(isEnable:true)
            } else {
                tfZipCode.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfPhoneNumber  {
            
            if textField.text?.count == 0 {
                tfPhoneNumber.showBoaderColor(isEnable:true)
            } else {
                tfPhoneNumber.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfEmailAddress {
             let isValid = viewModel.validateEmailAddress(email: textField.text ?? "")
            tfEmailAddress.showBoaderColor(isEnable: !isValid)
        }
        checkAllTheFeilds()
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
