//
//  RegisterPortalConfirm.swift
//  covid
//
//  Created by venkata baisani on 15/12/20.
//

import UIKit
import JBCalendarDatePicker

class RegisterPortalConfirm: UIViewController {
    
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBOutlet weak var backGrdViewOneHeight, backGrdViewTwoHeight, backGrdViewThreeHeight, backGrdViewFourHeight, backGrdViewFiveHeight, backGrdViewSixHeight, backGrdViewSevenHeight, backGrdViewEightHeight, backGrdViewNineHeight, backGrdViewTenHeight, backGrdViewElevenHeight, backGrdViewTwelveHeight : NSLayoutConstraint!
   
  
    @IBOutlet weak var backGrdViewOne, backGrdViewTwo, backGrdViewThree, backGrdViewFour, backGrdViewFive, backGrdViewSix, backGrdViewSeven, backGrdViewEight, backGrdViewNine, backGrdViewTen, backGrdViewEleven, backGrdViewTwelve : UIView!
    
    @IBOutlet weak var backGrdViewTwoFinal:UIView!
    
    @IBOutlet weak var btnEditOne,btnEditTwo,btnEditThree,btnEditFour,btnEditFive,btnEditSix,btnEditSeven,btnEditEight,btnEditNine,btnEditTen,btnEditEleven,btnEditTwelve: UIButton!
    
    @IBOutlet weak var lblEditFirstNameOne, lblEditMiddleNameTwo, lblEditLastNameThree, lblEditDateOfBirthFour, lblEditGenderFive, lblEditRactSix, lblEditAddressSeven, lblEditInsuranceProviderEight, lblEditPolicyNumberNine, lblEditPolicyHolderTen, lblEditIdentificationEleven, lblEditIdentificationAttachedTwelve : UILabel!
   
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var tfEditFirstNameOne, tfEditMiddleNameTwo, tfEditLastNameThree, tfEditDateOfBirthFour, tfEditGenderFive, tfRactSix, tfInsuranceProviderEight, tfEditPolicyNumberNine, tfEditPolicyHolderTen, tfEditIdentificationEleven, tfEditIdentificationAttachedTwelve : SutherlandTextField!
  
    @IBOutlet weak var tfAddressLineOne, tfAddressLineTwo, tfCity, tfState, tfZipCode : SutherlandTextField!
    
    @IBOutlet weak var btnDateSymBackGndView: UIView!
    
    @IBOutlet weak var identificationTitle:UILabel!
    
    var firstName:String? = "Venkata"
    var middleName:String? = "sudhakar"
    var lastName:String? = "Rao"
    var dateOfBirth:String? = "12/23/2020"
    var gender:String? = "Male"
    var race:String? = "aa"
    var addressLineOne:String? = "aa"
    var addressLineTwo:String? = "sss"
    var city:String? = "sfd"
    var state:String? = "sdf"
    var zipCode:String? = "3422"
    var insuranceProvider:String? = "4322"
    var policyNumber:String? = "sdfas"
    var policyHolderName:String? = "sdfa"
    var identification:String? = "dfa"
    var identificationAttached:String? = "ass.png"
    
    var genderVal:String?
    var raceVal:String?
    var identificationVal:String?
    
    var datePicker: JBDatePickerViewController!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        backGrdViewTwoHeight.constant = 0
        backGrdViewTwo.isHidden = true
        backGrdViewTwoFinal.isHidden = true
        
        // Do any additional setup after loading the view.
        identificationTitle.text = titles.identificationTitle
        
        btnNext.btnEnable(boolVal: true)
        // Do any additional setup after loading the view.
        setDefaultHeight()
        setPreviousData()
        setPreviousDetails()
        
       
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        let imagArr = self.view.subviews(ofType: UIImageView.self)
        
        for item in imagArr {
            let itemVal = item as UIImageView
            itemVal.backgroundColor = UIColor.Citygo.h1headingone
        }
        
        let btnArr = self.view.subviews(ofType: UIButton.self)
        
        for item in btnArr {
            let itemVal = item as UIButton
            if itemVal.titleLabel?.text == "Update" {
                itemVal.backgroundColor = UIColor.Citygo.buttonfieldsInactive
            }
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
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 120, right: 0)
        self.scrollViewReg.contentInset = contentInsets
        self.scrollViewReg.scrollIndicatorInsets = contentInsets
    }
   
    func setPreviousData() {
        
        self.firstName = SingletonData.shared.firstNamePatient
        self.lastName = SingletonData.shared.lastNamePatient
        self.dateOfBirth = SingletonData.shared.dateOfBirth
        self.gender = SingletonData.shared.gender
        self.race = SingletonData.shared.race
        self.addressLineOne = SingletonData.shared.addressLineOnePatient
        self.addressLineTwo = SingletonData.shared.addressLineTwoPatient
        self.city = SingletonData.shared.cityPatient
        self.state = SingletonData.shared.statePatient
        self.zipCode = SingletonData.shared.zipCodePatient
        self.insuranceProvider = SingletonData.shared.insuranceProvider
        self.policyNumber = SingletonData.shared.policyNumber
        self.policyHolderName = SingletonData.shared.policyHolderName
        self.identification = SingletonData.shared.identification
        self.identificationAttached = SingletonData.shared.identificationAttached
        self.raceVal = SingletonData.shared.raceVal
        self.genderVal = SingletonData.shared.genderVal
        self.identificationVal = SingletonData.shared.identificationVal
    }
    
    func setPreviousDetails() {
        lblEditFirstNameOne.text = firstName
        tfEditFirstNameOne.text = firstName
        
        lblEditMiddleNameTwo.text = middleName
        tfEditMiddleNameTwo.text = middleName
        
        lblEditLastNameThree.text = lastName
        tfEditLastNameThree.text = lastName
        
        lblEditDateOfBirthFour.text = dateOfBirth
        tfEditDateOfBirthFour.text = dateOfBirth
        
        lblEditGenderFive.text = gender
        tfEditGenderFive.text = gender
        
        lblEditRactSix.text = race
        tfRactSix.text = race
        
        lblEditAddressSeven.text = "\(addressLineOne ?? "") \n \(addressLineTwo ?? "") \n \(city ?? "") \n \(state ?? "") \n \(zipCode ?? "")"
        tfAddressLineOne.text = addressLineOne ?? ""
        tfAddressLineTwo.text = addressLineTwo ?? ""
        tfCity.text = city ?? ""
        tfState.text = state ?? ""
        tfZipCode.text = zipCode ?? ""
      
        lblEditInsuranceProviderEight.text = insuranceProvider
        tfInsuranceProviderEight.text = insuranceProvider
        
        lblEditPolicyNumberNine.text = policyNumber
        tfEditPolicyNumberNine.text = policyNumber
        
        lblEditPolicyHolderTen.text = policyHolderName
        tfEditPolicyHolderTen.text = policyHolderName
        
        lblEditIdentificationEleven.text = identification
        tfEditIdentificationEleven.text = identification
        
        lblEditIdentificationAttachedTwelve.text = identificationAttached
        tfEditIdentificationAttachedTwelve.text = identificationAttached
        
    }
    
    func setDefaultHeight() {
        //1
        backGrdViewOneHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        backGrdViewOne.isHidden = true
        //2
        backGrdViewTwo.isHidden = true
        backGrdViewTwoHeight.constant = 0
        //3
        backGrdViewThree.isHidden = true
        backGrdViewThreeHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //4
        backGrdViewFour.isHidden = true
        backGrdViewFourHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //5
        backGrdViewFive.isHidden = true
        backGrdViewFiveHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //6
        backGrdViewSix.isHidden = true
        backGrdViewSixHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //7
        backGrdViewSeven.isHidden = true
        backGrdViewSevenHeight.constant = viewHeight.ThirteenViewWithEditHeight_new.rawValue
        
        backGrdViewEight.isHidden = true
        backGrdViewEightHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewNine.isHidden = true
        backGrdViewNineHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewTen.isHidden = true
        backGrdViewTenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewEleven.isHidden = true
        backGrdViewElevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue

        backGrdViewTwelve.isHidden = true
        backGrdViewTwelveHeight.constant = 0
    
    }
    
    @IBAction func buttonCalPressed(_ sender: Any) {
        let calendarPicker = JBCalendarViewController()
        calendarPicker.popoverPresentationController?.sourceView = btnDateSymBackGndView
        calendarPicker.delegate = self
        // Configure the calendar's properties
        present(calendarPicker, animated: true, completion: nil)
    }
    
    @IBAction func buttonConfirmPressed(_ sender: Any) {
       
        if SingletonData.shared.isFromLogin ?? false {
            
            self.checkConnectivity()
            
        } else {
            
            //CreateAccountVC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"PatientFirstName\":\"\(SingletonData.shared.firstNamePatient ?? "")\",\"PatientLastName\":\"\(SingletonData.shared.lastNamePatient ?? "")\",\"Password\":\"\(SingletonData.shared.password ?? "")\"}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.values
            print("email verification: \(authUrl as Any)")
            SingletonData.shared.email = email
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "MyScheduleTestsViewController") as! MyScheduleTestsViewController
                        self.navigationController?.pushViewController(controller, animated: true)
                        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnEditAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        selBtn.isHidden = true
        if selBtn.tag == 500 {
            backGrdViewOne.isHidden = false
            backGrdViewOneHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 501 {
            backGrdViewTwo.isHidden = true
            backGrdViewTwoHeight.constant = 0
            
        } else if selBtn.tag == 502 {
            backGrdViewThree.isHidden = false
            backGrdViewThreeHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 503 {
            backGrdViewFour.isHidden = false
            backGrdViewFourHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 504 {
            backGrdViewFive.isHidden = false
            backGrdViewFiveHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 505 {
            backGrdViewSix.isHidden = false
            backGrdViewSixHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 506 {
            backGrdViewSeven.isHidden = false
            backGrdViewSevenHeight.constant = viewHeight.TwelveViewWithEditHeight.rawValue
        } else if selBtn.tag == 507 {
            backGrdViewEight.isHidden = false
            backGrdViewEightHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 508 {
            backGrdViewNine.isHidden = false
            backGrdViewNineHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 509 {
            backGrdViewTen.isHidden = false
            backGrdViewTenHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 510 {
            backGrdViewEleven.isHidden = false
            backGrdViewElevenHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 511 {
            backGrdViewTwelve.isHidden = false
            backGrdViewTwelveHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        }
    }
    
    @IBAction func btnUpdateAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 700 {
            backGrdViewOne.isHidden = true
            backGrdViewOneHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditOne.isHidden = false
          
            lblEditFirstNameOne.text = tfEditFirstNameOne.text
            firstName = tfEditFirstNameOne.text
            
        } else if selBtn.tag == 701 {
            backGrdViewTwo.isHidden = true
            backGrdViewTwoHeight.constant = 0
//            btnEditTwo.isHidden = false
//
//            middleName = tfEditMiddleNameTwo.text
//            lblEditMiddleNameTwo.text = tfEditMiddleNameTwo.text
            
        } else if selBtn.tag == 702 {
            backGrdViewThree.isHidden = true
            backGrdViewThreeHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditThree.isHidden = false
            
            lastName = tfEditLastNameThree.text
            lblEditLastNameThree.text = tfEditLastNameThree.text
            
        } else if selBtn.tag == 703 {
            backGrdViewFour.isHidden = true
            backGrdViewFourHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditFour.isHidden = false
            
            lblEditDateOfBirthFour.text = tfEditDateOfBirthFour.text
            dateOfBirth = tfEditDateOfBirthFour.text
            
        } else if selBtn.tag == 704 {
            backGrdViewFive.isHidden = true
            backGrdViewFiveHeight.constant = viewHeight.fifthViewWithOutEditHeight.rawValue
            btnEditFive.isHidden = false
            
            lblEditGenderFive.text = tfEditGenderFive.text
            gender = tfEditGenderFive.text
            
        } else if selBtn.tag == 705 {
            backGrdViewSix.isHidden = true
            backGrdViewSixHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditSix.isHidden = false
            
            lblEditRactSix.text = tfRactSix.text
            race = tfRactSix.text
            
        } else if selBtn.tag == 706 {
            backGrdViewSeven.isHidden = true
            backGrdViewSevenHeight.constant = viewHeight.TwelveViewWithOutEditHeight.rawValue
            btnEditSeven.isHidden = false
            
            addressLineOne = tfAddressLineOne.text
            addressLineTwo =  tfAddressLineTwo.text
            city =  tfCity.text
            state = tfState.text
            zipCode = tfZipCode.text
            
            lblEditAddressSeven.text = "\(addressLineOne ?? "") \n \(addressLineTwo ?? "") \n \(city ?? "") \n \(state ?? "") \n \(zipCode ?? "")"
            
        
        } else if selBtn.tag == 707 {
            backGrdViewEight.isHidden = true
            backGrdViewEightHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditEight.isHidden = false
            
            lblEditInsuranceProviderEight.text = tfInsuranceProviderEight.text
            insuranceProvider = tfInsuranceProviderEight.text
            
        } else if selBtn.tag == 708 {
            backGrdViewNine.isHidden = true
            backGrdViewNineHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditNine.isHidden = false
            
            lblEditPolicyNumberNine.text = tfEditPolicyNumberNine.text
            policyNumber = tfEditPolicyNumberNine.text
            
        } else if selBtn.tag == 709 {
            backGrdViewTen.isHidden = true
            backGrdViewTenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditTen.isHidden = false
            
            lblEditPolicyHolderTen.text = tfEditPolicyHolderTen.text
            policyHolderName = tfEditPolicyNumberNine.text
            
        } else if selBtn.tag == 710 {
            backGrdViewEleven.isHidden = true
            backGrdViewElevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditEleven.isHidden = false
            
            lblEditIdentificationEleven.text = tfEditIdentificationEleven.text
            identification = tfEditIdentificationEleven.text
            
        } else if selBtn.tag == 711 {
            backGrdViewTwelve.isHidden = true
            backGrdViewTwelveHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditTwelve.isHidden = false
            
            lblEditIdentificationAttachedTwelve.text = tfEditIdentificationAttachedTwelve.text
            identificationAttached = tfEditIdentificationAttachedTwelve.text
        }
        self.view.endEditing(true)
    }

}

extension RegisterPortalConfirm: JBCalendarViewControllerDelegate {
    func calendarViewControllerDateChanged(_ calendarViewController: JBCalendarViewController) {
        print(calendarViewController.date)
        tfEditDateOfBirthFour.text = calendarViewController.date.convertToDateFormat()
        calendarViewController.dismiss(animated: true, completion: nil)
    }
    
    func calendarViewControllerWillDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
    func calendarViewControllerDidDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
}
extension RegisterPortalConfirm: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
