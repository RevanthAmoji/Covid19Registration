//
//  RegisterPortalTwo.swift
//  covid
//
//  Created by venkata baisani on 11/12/20.
//

import UIKit

class RegisterPortalTwo: UIViewController {
    
    @IBOutlet weak var tfAddressLineOne: SutherlandTextField!
    @IBOutlet weak var tfAddressLineTwo: SutherlandTextField!
    @IBOutlet weak var tfCity: SutherlandTextField!
    @IBOutlet weak var tfState: SutherlandTextField!
    @IBOutlet weak var tfZipCode: SutherlandTextField!
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
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
        
        if tfAddressLineOne.text?.count == 0 || tfAddressLineOne == nil {
            errorMessage = "Please enter patient last name"
        } else if tfAddressLineTwo.text?.count == 0 || tfAddressLineTwo == nil {
            errorMessage = "Please enter patient last name"
        } else if tfCity.text?.count == 0 || tfCity == nil {
            errorMessage = "Please select consent from the patient to register on their behalf"
        } else if tfState.text?.count == 0 || tfState == nil {
            errorMessage = "Please enter signature"
        } else if tfZipCode.text?.count == 0 || tfZipCode == nil {
            errorMessage = "Please enter patient last name"
        } else {
            btnNext.btnEnable(boolVal: true)
            return
        }
        //self.showsAlertWithoutWhiteBg(titleVal: "", messageVal: errorMessage)
        print(errorMessage)
    }

}

extension RegisterPortalTwo: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == tfAddressLineOne  {
            
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
        }
        checkAllTheFeilds()
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
