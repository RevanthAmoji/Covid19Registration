//
//  InitialVC.swift
//  covid
//
//  Created by venkata baisani on 16/11/20.
//

import UIKit

class InitialVC: UIViewController {
    
    @IBOutlet weak var tfRelationShip: SutherlandTextField!
    @IBOutlet weak var tfRelationShipDummy: SutherlandTextField!
    @IBOutlet weak var tfPatientFirstName: SutherlandTextField!
    @IBOutlet weak var tfPatientLastName: SutherlandTextField!
    @IBOutlet weak var tfSignature: SutherlandTextField!
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var btnAgeTrue: UIButton!
    @IBOutlet weak var btnAgefalse: UIButton!
    
    @IBOutlet weak var btnImageDropdown: UIButton!
    @IBOutlet weak var btnDropdown: UIButton!
    
    @IBOutlet weak var btnRegisterTrue: UIButton!
    @IBOutlet weak var btnRegisterfalse: UIButton!
    
    @IBOutlet weak var ageViewHeight:NSLayoutConstraint!
    @IBOutlet weak var nameViewHeight:NSLayoutConstraint!
    @IBOutlet weak var registerViewHeight:NSLayoutConstraint!
    @IBOutlet weak var signatureViewHeight:NSLayoutConstraint!
    
    @IBOutlet weak var ageViewHeightView:UIView!
    @IBOutlet weak var nameViewHeightView:UIView!
    @IBOutlet weak var registerViewHeightView:UIView!
    @IBOutlet weak var signatureViewHeighViewt:UIView!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var dropDownBackgroundView:UIView!
    @IBOutlet weak var dropDownTableViewBackGroundView:UIView!
    
    @IBOutlet weak var languagesTableView: UITableView!
   
    var languagesList:[String] = ["Myself","Spouse","Child","Other"]
    
    var selectionAge:String? = ""
    var selectionRegister:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraintValues()
        //textfieldsBackGndColor()
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        self.heighlighBoarderColor(boolVal: false)
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

    func setConstraintValues(){
        
        btnNext.btnEnable(boolVal: false)
        
        ageViewHeight.constant = 0
        nameViewHeight.constant = 0
        registerViewHeight.constant = 0
        signatureViewHeight.constant = 0
        
        ageViewHeightView.isHidden = true
        nameViewHeightView.isHidden = true
        registerViewHeightView.isHidden = true
        signatureViewHeighViewt.isHidden = true
        
        btnNext.layoutIfNeeded()
        btnNext.frame = CGRect(x: 0, y: scrollViewReg.contentSize.height-32-39, width: 102, height: 39)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func nextBtnAction(_ sender: Any) {
    
        print("nextbtnaction")
    }

    @IBAction func dropdownBtnAction(_ sender: Any) {
    
        self.heighlighBoarderColor(boolVal: true)
    }
    
    @IBAction func reloationshipBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 100 {
            
            selectionAge = "Yes"
            btnAgefalse.isSelected = false
            btnAgeTrue.isSelected = true
            
        } else if selBtn.tag == 101 {
            
            selectionAge = "No"
            btnAgeTrue.isSelected = false
            btnAgefalse.isSelected = true
        }
        
        nameViewHeight.constant = 203
        nameViewHeightView.isHidden = false
        
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 102 {
            
            selectionRegister = "Yes"
            btnRegisterfalse.isSelected = false
            btnRegisterTrue.isSelected = true
            
        } else if selBtn.tag == 103 {
            
            selectionRegister = "No"
            btnRegisterTrue.isSelected = false
            btnRegisterfalse.isSelected = true
        }
        
        signatureViewHeight.constant = 230
        signatureViewHeighViewt.isHidden = false
        
    }
    
    func heighlighBoarderColor(boolVal: Bool){
       
 //       dropDownBackgroundView.sendSubviewToBack(self.navigationController!.view)
//        tfRelationShip.bringSubviewToFront(dropDownBackgroundView)
//        btnImageDropdown.bringSubviewToFront(dropDownBackgroundView)
//        btnDropdown.bringSubviewToFront(dropDownBackgroundView)
        
        dropDownBackgroundView.bringSubviewToFront(tfRelationShip)
        self.view.bringSubviewToFront(btnImageDropdown)
        self.view.bringSubviewToFront(btnDropdown)
        
        dropDownBackgroundView.isHidden = !boolVal
        
        if boolVal {
            tfRelationShip.layer.borderColor = UIColor.Citygo.redColor.cgColor
            tfRelationShipDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            tfRelationShip.layer.borderColor = UIColor.clear.cgColor
            tfRelationShipDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor

        }
        
        tfRelationShip.layer.borderWidth = 0.4
        tfRelationShip.layer.cornerRadius = 5.0
        
        tfRelationShipDummy.layer.borderWidth = 0.4
        tfRelationShipDummy.layer.cornerRadius = 5.0
    }
//
//    func textfieldsBackGndColor() {
//        tfRelationShip.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
//        tfSignature.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
//        tfPatientLastName.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
//        tfPatientFirstName.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
//    }
    
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
    
    func checkAllTheFeilds() {
        var errorMessage = ""
        if tfRelationShip.text?.count == 0 {
            errorMessage = "Please select relation"
        } else if selectionAge?.count == 0 || selectionAge == nil {
            errorMessage = "Please select under the age of 18"
        } else if tfPatientFirstName.text?.count == 0 || tfPatientFirstName == nil {
            errorMessage = "Please enter patient first name"
        } else if tfPatientLastName.text?.count == 0 || tfPatientLastName == nil {
            errorMessage = "Please enter patient last name"
        } else if selectionRegister?.count == 0 || selectionRegister == nil {
            errorMessage = "Please select consent from the patient to register on their behalf"
        } else if tfSignature.text?.count == 0 || tfSignature == nil {
            errorMessage = "Please enter signature"
        } else {
            btnNext.btnEnable(boolVal: true)
            SingletonData.shared.firstNamePatient = tfPatientFirstName.text
            SingletonData.shared.lastNamePatient = tfPatientLastName.text

            return
        }
       // self.showsAlertWithoutWhiteBg(titleVal: "", messageVal: errorMessage)
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

}

extension InitialVC: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesCell", for: indexPath) as! LanguagesCell
        cell.titleLbl.text = languagesList[indexPath.row]
        if cell.titleLbl.text == "Myself" {
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        }
        cell.titleLbl.textColor = UIColor.Citygo.formsubtitlesnotselected
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.heighlighBoarderColor(boolVal: false)
        tfRelationShip.text = languagesList[indexPath.row]
        tfRelationShipDummy.text = languagesList[indexPath.row]
        ageViewHeight.constant = 102
        ageViewHeightView.isHidden = false
    }
}

extension InitialVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfPatientFirstName {
            if  textField.text?.count != 0 {
                
                registerViewHeight.constant = 125
                registerViewHeightView.isHidden = false
            }
        } else  if textField == tfSignature {
            if  textField.text?.count != 0 {
                
                self.checkAllTheFeilds()
            }
        } else  if textField == tfPatientLastName {
            
            if  textField.text?.count != 0 {
                
                self.checkAllTheFeilds()
            }
        }
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
