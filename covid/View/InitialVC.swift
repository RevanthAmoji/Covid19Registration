//
//  InitialVC.swift
//  covid
//
//  Created by venkata baisani on 16/11/20.
//

import UIKit

class InitialVC: UIViewController,ProgressBarShower {
    
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
    
    @IBOutlet weak var dropDownBackgroundGenderView:UIView!
    @IBOutlet weak var dropDownTableViewBackGroundGenderView:UIView!
    
    @IBOutlet weak var languagesTableView: UITableView!
    @IBOutlet weak var genderTableView: UITableView!
    
    @IBOutlet weak var infoLbl: SutherlandLabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tfGender: SutherlandTextField!
    @IBOutlet weak var tfGenderDummy: SutherlandTextField!
   
    var languagesList:[RelationModel] = []
    var genderList:[RelationModel] = []
    
    var selectionAge:String? = ""
    var selectionRegister:String? = ""
    var selectRelationNumber:String? = ""
    var selectGenderNumber:String? = ""
    
    var gender:String = "-1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraintValues()
        //textfieldsBackGndColor()
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        self.heighlighBoarderColor(boolVal: false)
        self.heighlighGenderBoarderColor(boolVal: false)
        
       checkConnectivityRelation()
    
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       
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
        
        if SingletonData.shared.StatusCode == 0 {
            
            tfRelationShip.text = SingletonData.shared.relationName
            tfRelationShipDummy.text = SingletonData.shared.relationName
            selectRelationNumber = SingletonData.shared.relationNumber
            
            selectionAge = SingletonData.shared.patientAge
            if selectionAge == checkBoxInt.trueVal.rawValue {
                btnAgeTrue.isSelected = true
            } else if selectionAge == checkBoxInt.falseVal.rawValue  {
                btnAgefalse.isSelected = true
            }
            
            tfPatientFirstName.text = SingletonData.shared.firstNamePatient
            tfPatientLastName.text = SingletonData.shared.lastNamePatient
            
            selectionRegister = SingletonData.shared.consent
            if selectionRegister == checkBoxInt.trueVal.rawValue {
                btnRegisterTrue.isSelected = true
            } else if selectionRegister == checkBoxInt.falseVal.rawValue {
                btnRegisterfalse.isSelected = true
            }
            
            tfSignature.text = SingletonData.shared.guardianFullName
            
            btnNext.btnEnable(boolVal: true)
            
        }
//        else {
//
//            btnNext.btnEnable(boolVal: false)
//
//            ageViewHeight.constant = 0
//            nameViewHeight.constant = 0
//            registerViewHeight.constant = 0
//            signatureViewHeight.constant = 0
//
//            ageViewHeightView.isHidden = true
//            nameViewHeightView.isHidden = true
//            registerViewHeightView.isHidden = true
//            signatureViewHeighViewt.isHidden = true
//
//            btnNext.layoutIfNeeded()
//            btnNext.frame = CGRect(x: 0, y: scrollViewReg.contentSize.height-32-39, width: 102, height: 39)
//        }
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
    
        SingletonData.shared.gender = tfGender.text
        SingletonData.shared.genderVal = selectGenderNumber
        SingletonData.shared.firstNamePatient = tfPatientFirstName.text
        SingletonData.shared.lastNamePatient = tfPatientLastName.text
        SingletonData.shared.relationName = tfRelationShip.text
        SingletonData.shared.relationNumber = selectRelationNumber
        checkConnectivity()
        print("nextbtnaction")
    }

    @IBAction func dropdownBtnAction(_ sender: Any) {
    
        self.heighlighBoarderColor(boolVal: true)
        languagesTableView.reloadData()
    }
    @IBAction func dropdownBtnGenderAction(_ sender: Any) {
    
        self.heighlighGenderBoarderColor(boolVal: true)
        genderTableView.reloadData()
    }
    
    
    @IBAction func reloationshipBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 100 {
            
            selectionAge = "1"
            btnAgefalse.isSelected = false
            btnAgeTrue.isSelected = true
            
        } else if selBtn.tag == 101 {
            
            selectionAge = "0"
            btnAgeTrue.isSelected = false
            btnAgefalse.isSelected = true
        }
        
//        nameViewHeight.constant = 203
//        nameViewHeightView.isHidden = false
        
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
    
        let selBtn = sender as! UIButton
        
        if selBtn.tag == 102 {
            
            selectionRegister = "1"
            btnRegisterfalse.isSelected = false
            btnRegisterTrue.isSelected = true
            
        } else if selBtn.tag == 103 {
            
            selectionRegister = "0"
            btnRegisterTrue.isSelected = false
            btnRegisterfalse.isSelected = true
        }
        
//        signatureViewHeight.constant = 230
//        signatureViewHeighViewt.isHidden = false
        
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
    func heighlighGenderBoarderColor(boolVal: Bool){
 
 //       dropDownBackgroundGenderView.bringSubviewToFront(tfGender)
//        self.view.bringSubviewToFront(btnImageDropdown)
//        self.view.bringSubviewToFront(btnDropdown)
        
        dropDownBackgroundGenderView.isHidden = !boolVal
        
        if boolVal {
            tfGender.layer.borderColor = UIColor.Citygo.redColor.cgColor
            tfGenderDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            tfGender.layer.borderColor = UIColor.clear.cgColor
            tfGenderDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor

        }
        
        tfGender.layer.borderWidth = 0.4
        tfGender.layer.cornerRadius = 5.0
        
        tfGenderDummy.layer.borderWidth = 0.4
        tfGenderDummy.layer.cornerRadius = 5.0
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
        //btnNext.btnEnable(boolVal: false)
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
            
            if tfRelationShip.text == "Myself" {
                btnNext.btnEnable(boolVal: true)
                SingletonData.shared.firstNamePatient = tfPatientFirstName.text
                SingletonData.shared.lastNamePatient = tfPatientLastName.text
            }
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
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func checkConnectivity() {
        //Patient_Gender
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"PatientRelationship\":\"\(selectRelationNumber ?? "")\",\"PatientAge\":\"\(selectionAge ?? "")\",\"PatientFirstName\":\"\(tfPatientFirstName.text ?? "")\",\"PatientLastName\":\"\(tfPatientLastName.text ?? "")\",\"PatientConsent\":\"\(selectionRegister ?? "")\",\"Patient_Gender\":\"\(selectGenderNumber ?? "")\",\"GuardianFullName\":\"\(tfSignature.text ?? "")\"}'}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterScreenOne") as! RegisterScreenOne
                        self.navigationController?.pushViewController(controller, animated: false)
                    } else {
                        self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                    }
                    
                case .failure( _):
                    self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                }
            })
        } else {
            self.hideProgressBar()
            self.showsAlertWithoutWhiteBg(titleVal: "Network Error", messageVal: "Unable to access the Network")
        }
    }

    func checkConnectivityRelation() {
        self.showProgressBar()
        
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.relation
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getRelationData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.showProgressBar()
                    if dashboads.count != 0 {
                        
                        self.languagesList = dashboads
                        self.languagesTableView.reloadData()
                        self.checkConnectivityGender()
                        
                    } else {
                        
                        self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                        
                    }
                    
                case .failure( _):
                    self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                }
            })
        } else {
            self.hideProgressBar()
            self.showsAlertWithoutWhiteBg(titleVal: "Network Error", messageVal: "Unable to access the Network")
       }
    }
    
    func checkConnectivityGender() {
        
        self.showProgressBar()
        
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.gender
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getRelationData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.count != 0 {
                        
                        self.genderList = dashboads
                        self.genderTableView.reloadData()
                        
                    } else {
                        
                        self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                    }
                case .failure( _):
                    self.hideProgressBar()
                    //something went wrong, print the error.
                    self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                }
            })
        } else {
            self.hideProgressBar()
            self.showsAlertWithoutWhiteBg(titleVal: "Network Error", messageVal: "Unable to access the Network")
       }
    }

}

extension InitialVC: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == genderTableView {
            return genderList.count
        } else {
            return languagesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesCell", for: indexPath) as! LanguagesCell
        
        if tableView == genderTableView {
            
            cell.titleLbl.text = genderList[indexPath.row].Text
            cell.contentView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        
            cell.titleLbl.textColor = UIColor.Citygo.formsubtitlesnotselected
            
        } else {
            
            cell.titleLbl.text = languagesList[indexPath.row].Text
            if cell.titleLbl.text == "Myself" {
                cell.contentView.backgroundColor = UIColor.white
                
            } else {
                cell.contentView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
            }
            cell.titleLbl.textColor = UIColor.Citygo.formsubtitlesnotselected
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == genderTableView {
            
            self.heighlighGenderBoarderColor(boolVal: false)
            tfGender.text = genderList[indexPath.row].Text
            tfGenderDummy.text = genderList[indexPath.row].Text
            selectGenderNumber = genderList[indexPath.row].Value
            
        } else {
            
            self.heighlighBoarderColor(boolVal: false)
            tfRelationShip.text = languagesList[indexPath.row].Text
            tfRelationShipDummy.text = languagesList[indexPath.row].Text
            selectRelationNumber = languagesList[indexPath.row].Value
            //        ageViewHeight.constant = 102
            //        ageViewHeightView.isHidden = false
            
            if tfRelationShip.text != "Myself" && ((tfPatientFirstName.text?.count) != 0) {
               // btnNext.btnEnable(boolVal: false)
                registerViewHeight.constant = 125
                registerViewHeightView.isHidden = false
            } else if tfRelationShip.text == "Myself" && registerViewHeight.constant == 125 {
                btnNext.btnEnable(boolVal: true)
                registerViewHeight.constant = 0
                registerViewHeightView.isHidden = true
                signatureViewHeight.constant = 0
                signatureViewHeighViewt.isHidden = true
                selectionRegister = ""
                tfSignature.text = ""
                btnRegisterfalse.isSelected = false
                btnRegisterTrue.isSelected = false
            } else {
                registerViewHeight.constant = 125
                registerViewHeightView.isHidden = false
                signatureViewHeight.constant = 230
                signatureViewHeighViewt.isHidden = false
                selectionRegister = ""
                tfSignature.text = ""
                btnRegisterfalse.isSelected = false
                btnRegisterTrue.isSelected = false
            }
            checkAllTheFeilds()
        }
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
                self.checkAllTheFeilds()
//                if tfRelationShip.text != "Myself" {
//                  registerViewHeight.constant = 125
//                  registerViewHeightView.isHidden = false
//                }
            }
        } else  if textField == tfSignature {
            if  textField.text?.count != 0 {
                
                infoLbl.text = "I, \(tfSignature.text ?? "") acknowledge that I have the full consent of \(tfPatientFirstName.text ?? " ") \( tfPatientLastName.text ?? "") to register on their behalf and any misrepresentation of their provided details is my sole responsbility"
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
        if textField == tfSignature {
            let text = textField.text
            let _char = string.cString(using: .utf8)
            let isBackSpace =  strcmp(_char, "x")
            if isBackSpace == -120 {
                    
                return true
            } else {
                infoLbl.text = "I, \(text ?? "")\(string) acknowledge that I have the full consent of \(tfPatientFirstName.text ?? " ") \( tfPatientLastName.text ?? "") to register on their behalf and any misrepresentation of their provided details is my sole responsbility"
                    return true
            }

        }
      return true
    }
}
