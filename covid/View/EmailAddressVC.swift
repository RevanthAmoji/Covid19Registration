//
//  EmailAddressVC.swift
//  covid
//
//  Created by venkata baisani on 18/11/20.
//

import UIKit

class EmailAddressVC: UIViewController {
    
    // Intialize view model variable
    var viewModel = EmailAddressViewModel()
    
    // Initialize email textField variable
    @IBOutlet weak var emailTF: SutherlandTextField!
    @IBOutlet weak var reenterEmailTF: SutherlandTextField!
    @IBOutlet weak var nextBtn: SutherlandButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextBtn.btnEnable(boolVal: false)
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
