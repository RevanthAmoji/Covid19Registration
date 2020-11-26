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

    var primaryCareProvider:String? = ""
    var careFacility:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fieldsViewHeight.constant = 0
        backGndView.isHidden = true
        
        btnNext.btnEnable(boolVal: false)
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
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
            primaryCareProvider = "Yes"
            btnPrimaryCareProviderfalse.isSelected = false
            btnPrimaryCareProviderTrue.isSelected = true
            fieldsViewHeight.constant = 780
            backGndView.isHidden = false
        } else if selBtn.tag == 101 {
            primaryCareProvider = "No"
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
            careFacility = "Yes"
            btnCareFacilityfalse.isSelected = false
            btnCareFacilityTrue.isSelected = true
        } else if selBtn.tag == 103 {
            careFacility = "No"
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
        btnNext.btnEnable(boolVal: false)
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
