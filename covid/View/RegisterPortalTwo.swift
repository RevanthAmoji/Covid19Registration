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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
