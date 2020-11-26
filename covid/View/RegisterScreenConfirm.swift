//
//  RegisterScreenConfirm.swift
//  covid
//
//  Created by venkata baisani on 24/11/20.
//

import UIKit
import JBCalendarDatePicker

enum viewHeight: CGFloat {
    case symptomsWithEditHeight = 160.0
    case symptomsWithOutEditHeight = 100.0
    case dateSymptomsWithEditHeight = 150.0
    case fifthViewWithOutEditHeight = 120.0
    case TwelveViewWithOutEditHeight = 180.0
    case TwelveViewWithEditHeight = 600.0
    case ThirteenViewWithEditHeight = 300.0
}

enum checkBox: String {
    case trueVal = "Yes"
    case falseVal = "No"
}

class RegisterScreenConfirm: UIViewController {

    @IBOutlet weak var symptomsHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewTwoHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewThreeHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewFourHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewFiveHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewSixHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewSevenHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewEightHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewNineHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewTenHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewElevenHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewTwelveHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewThirteenHeight: NSLayoutConstraint!
    @IBOutlet weak var backGrdViewFourteenHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var symptomsBackGrdView: UIView!
    @IBOutlet weak var backGrdViewTwo: UIView!
    @IBOutlet weak var backGrdViewThree: UIView!
    @IBOutlet weak var backGrdViewFour: UIView!
    @IBOutlet weak var backGrdViewFive: UIView!
    @IBOutlet weak var backGrdViewSix: UIView!
    @IBOutlet weak var backGrdViewSeven: UIView!
    @IBOutlet weak var backGrdViewEight: UIView!
    @IBOutlet weak var backGrdViewNine: UIView!
    @IBOutlet weak var backGrdViewTen: UIView!
    @IBOutlet weak var backGrdViewEleven: UIView!
    @IBOutlet weak var backGrdViewTwelve: UIView!
    @IBOutlet weak var backGrdViewThirteen: UIView!
    @IBOutlet weak var backGrdViewFourteen: UIView!
    
    
    @IBOutlet weak var btnEditOne: UIButton!
    @IBOutlet weak var btnEditTwo: UIButton!
    @IBOutlet weak var btnEditThree: UIButton!
    @IBOutlet weak var btnEditFour: UIButton!
    @IBOutlet weak var btnEditFive: UIButton!
    @IBOutlet weak var btnEditSix: UIButton!
    @IBOutlet weak var btnEditSeven: UIButton!
    @IBOutlet weak var btnEditEight: UIButton!
    @IBOutlet weak var btnEditNine: UIButton!
    @IBOutlet weak var btnEditTen: UIButton!
    @IBOutlet weak var btnEditEleven: UIButton!
    @IBOutlet weak var btnEditTwelve: UIButton!
    @IBOutlet weak var btnEditThirteen: UIButton!
    @IBOutlet weak var btnEditFourteen: UIButton!
    
    @IBOutlet weak var lblEditSymptomsOne: UILabel!
    @IBOutlet weak var lblEditdateSymptomsStartedTwo: UILabel!
    @IBOutlet weak var lblEditProritizedForTestingThree: UILabel!
    @IBOutlet weak var lblEditFirstTimeTestingFour: UILabel!
    @IBOutlet weak var lblEditContactWithAnyOneFive: UILabel!
    @IBOutlet weak var lblEditMedicalConditionSix: UILabel!
    @IBOutlet weak var lblEditPregnantSeven: UILabel!
    @IBOutlet weak var lblEditHighRiskCategoryEight: UILabel!
    @IBOutlet weak var lblEditSmokerNine: UILabel!
    @IBOutlet weak var lblEditPrimaryCareProviderTen: UILabel!
    @IBOutlet weak var lblEditCareProviderEleven: UILabel!
    @IBOutlet weak var lblEditAddressOfCareProviderTwelve: UILabel!
    @IBOutlet weak var lblEditContactDetailsThirteen: UILabel!
    @IBOutlet weak var lblEditCareFacilityFourteen: UILabel!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var btntrueOne, btntrueTwo, btntrueThree, btntrueFour,btntrueFive, btntrueSix, btntrueSeven,btntrueEight, btntrueNine, btntrueTen: UIButton!
    @IBOutlet weak var btnfalseOne, btnfalseTwo, btnfalseThree, btnfalseFour,btnfalseFive, btnfalseSix, btnfalseSeven,btnfalseEight, btnfalseNine, btnfalseTen: UIButton!
    
    @IBOutlet weak var tfDateSymStarted: UITextField!
    @IBOutlet weak var btnDateSym: UIButton!
    @IBOutlet weak var btnDateSymBackGndView: UIView!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var tfCareProvider, tfAddressLineOne, tfAddressLineTwo, tfCity, tfState, tfZipCode, tfPhoneNumber,tfEmailAddress  : SutherlandTextField!

    var symptoms:String?
    var dateSymptomsStarted:String?
    var proritizedForTesting:String?
    var firstTimeTesting:String?
    var contactWithAnyOne:String?
    var medicalCondition:String?
    var pregnant:String?
    var highRiskCategory:String?
    var smoker:String?
    var primaryCareProvider:String?
    var careFacility:String?
    var careProvider:String?
    var addressLineOne:String?
    var addressLineTwo:String?
    var city:String?
    var state:String?
    var zipCode:String?
    var phoneNumber:String?
    var emailAddress:String?
    
    var datePicker: JBDatePickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.btnEnable(boolVal: true)
        // Do any additional setup after loading the view.
        setDefaultHeight()
        setPreviousData()
        setPreviousDetails()
       
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
    
    func setPreviousData() {
        
        self.symptoms = SingletonData.shared.symptoms
        self.dateSymptomsStarted = SingletonData.shared.dateSymptomsStarted
        self.proritizedForTesting = SingletonData.shared.proritizedForTesting
        self.firstTimeTesting = SingletonData.shared.firstTimeTesting
        self.contactWithAnyOne = SingletonData.shared.contactWithAnyOne
        self.medicalCondition = SingletonData.shared.medicalCondition
        self.pregnant = SingletonData.shared.pregnant
        self.highRiskCategory = SingletonData.shared.highRiskCategory
        self.smoker = SingletonData.shared.smoker
        self.primaryCareProvider = SingletonData.shared.primaryCareProvider
        self.careFacility = SingletonData.shared.careFacility
        self.careProvider = SingletonData.shared.careProvider
        self.addressLineOne = SingletonData.shared.addressLineOne
        self.addressLineTwo = SingletonData.shared.addressLineTwo
        self.city = SingletonData.shared.city
        self.state = SingletonData.shared.state
        self.zipCode = SingletonData.shared.zipCode
        self.phoneNumber = SingletonData.shared.phoneNumber
        self.emailAddress = SingletonData.shared.emailAddress
        
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
    func setPreviousDetails() {
        lblEditSymptomsOne.text = symptoms
        if lblEditSymptomsOne.text == "Yes" {
            btntrueOne.isSelected = true
            btnfalseOne.isSelected = false
        } else {
            btntrueOne.isSelected = false
            btnfalseOne.isSelected = true
        }
        
        lblEditdateSymptomsStartedTwo.text = dateSymptomsStarted
        tfDateSymStarted.text = dateSymptomsStarted
        
        lblEditProritizedForTestingThree.text = proritizedForTesting
        if lblEditProritizedForTestingThree.text == "Yes" {
            btntrueTwo.isSelected = true
            btnfalseTwo.isSelected = false
        } else {
            btntrueTwo.isSelected = false
            btnfalseTwo.isSelected = true
        }
        
        lblEditFirstTimeTestingFour.text = firstTimeTesting
        if lblEditFirstTimeTestingFour.text == "Yes" {
            btntrueThree.isSelected = true
            btnfalseThree.isSelected = false
        } else {
            btntrueThree.isSelected = false
            btnfalseThree.isSelected = true
        }
        
        lblEditContactWithAnyOneFive.text = contactWithAnyOne
        if lblEditContactWithAnyOneFive.text == "Yes" {
            btntrueFour.isSelected = true
            btnfalseFour.isSelected = false
        } else {
            btntrueFour.isSelected = false
            btnfalseFour.isSelected = true
        }
        
        lblEditMedicalConditionSix.text = medicalCondition
        if lblEditMedicalConditionSix.text == "Yes" {
            btntrueFive.isSelected = true
            btnfalseFive.isSelected = false
        } else {
            btntrueFive.isSelected = false
            btnfalseFive.isSelected = true
        }
        
        lblEditPregnantSeven.text = pregnant
        if lblEditMedicalConditionSix.text == "Yes" {
            btntrueSix.isSelected = true
            btnfalseSix.isSelected = false
        } else {
            btntrueSix.isSelected = false
            btnfalseSix.isSelected = true
        }
        
        lblEditHighRiskCategoryEight.text = highRiskCategory
        if lblEditHighRiskCategoryEight.text == "Yes" {
            btntrueSeven.isSelected = true
            btnfalseSeven.isSelected = false
        } else {
            btntrueSeven.isSelected = false
            btnfalseSeven.isSelected = true
        }
        
        lblEditSmokerNine.text = smoker
        if lblEditSmokerNine.text == "Yes" {
            btntrueEight.isSelected = true
            btnfalseEight.isSelected = false
        } else {
            btntrueEight.isSelected = false
            btnfalseEight.isSelected = true
        }
        
        lblEditPrimaryCareProviderTen.text = primaryCareProvider
        if lblEditPrimaryCareProviderTen.text == "Yes" {
            btntrueNine.isSelected = true
            btnfalseNine.isSelected = false
        } else {
            btntrueNine.isSelected = false
            btnfalseNine.isSelected = true
        }
        
        lblEditCareProviderEleven.text = careProvider
        tfCareProvider.text = careProvider
        
        lblEditAddressOfCareProviderTwelve.text = "\(addressLineOne ?? "") \n \(addressLineTwo ?? "") \n \(city ?? "") \n \(state ?? "") \n \(zipCode ?? "")"
        tfAddressLineOne.text = addressLineOne ?? ""
        tfAddressLineTwo.text = addressLineTwo ?? ""
        tfCity.text = city ?? ""
        tfState.text = state ?? ""
        tfZipCode.text = zipCode ?? ""
        
        lblEditContactDetailsThirteen.text = "\(phoneNumber ?? "") \n \(emailAddress ?? "")"
        tfPhoneNumber.text = phoneNumber ?? ""
        tfEmailAddress.text = emailAddress ?? ""
        
        lblEditCareFacilityFourteen.text = careFacility
        if lblEditCareFacilityFourteen.text == "Yes" {
            btntrueTen.isSelected = true
            btnfalseTen.isSelected = false
        } else {
            btntrueTen.isSelected = false
            btnfalseTen.isSelected = true
        }
        
    }
    
    func setDefaultHeight() {
        //1
        symptomsHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        symptomsBackGrdView.isHidden = true
        //2
        backGrdViewTwo.isHidden = true
        backGrdViewTwoHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //3
        backGrdViewThree.isHidden = true
        backGrdViewThreeHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //4
        backGrdViewFour.isHidden = true
        backGrdViewFourHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //5
        backGrdViewFive.isHidden = true
        backGrdViewFiveHeight.constant = viewHeight.fifthViewWithOutEditHeight.rawValue
        //6
        backGrdViewSix.isHidden = true
        backGrdViewSixHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        //7
        backGrdViewSeven.isHidden = true
        backGrdViewSevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewEight.isHidden = true
        backGrdViewEightHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewNine.isHidden = true
        backGrdViewNineHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewTen.isHidden = true
        backGrdViewTenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
        
        backGrdViewEleven.isHidden = true
        backGrdViewElevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue

        backGrdViewTwelve.isHidden = true
        backGrdViewTwelveHeight.constant = viewHeight.TwelveViewWithOutEditHeight.rawValue
        
        backGrdViewThirteen.isHidden = true
        backGrdViewThirteenHeight.constant = viewHeight.fifthViewWithOutEditHeight.rawValue
        
        backGrdViewFourteen.isHidden = true
        backGrdViewFourteenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonCalPressed(_ sender: Any) {
        let calendarPicker = JBCalendarViewController()
        calendarPicker.popoverPresentationController?.sourceView = btnDateSymBackGndView
        calendarPicker.delegate = self
        // Configure the calendar's properties
        present(calendarPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        selBtn.isHidden = true
        if selBtn.tag == 500 {
            symptomsBackGrdView.isHidden = false
            symptomsHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 501 {
            backGrdViewTwo.isHidden = false
            backGrdViewTwoHeight.constant = viewHeight.dateSymptomsWithEditHeight.rawValue
            
        } else if selBtn.tag == 502 {
            backGrdViewThree.isHidden = false
            backGrdViewThreeHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 503 {
            backGrdViewFour.isHidden = false
            backGrdViewFourHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 504 {
            backGrdViewFive.isHidden = false
            backGrdViewFiveHeight.constant = viewHeight.TwelveViewWithOutEditHeight.rawValue
        } else if selBtn.tag == 505 {
            backGrdViewSix.isHidden = false
            backGrdViewSixHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        } else if selBtn.tag == 506 {
            backGrdViewSeven.isHidden = false
            backGrdViewSevenHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
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
            backGrdViewTwelveHeight.constant = viewHeight.TwelveViewWithEditHeight.rawValue
        } else if selBtn.tag == 512 {
            backGrdViewThirteen.isHidden = false
            backGrdViewThirteenHeight.constant = viewHeight.ThirteenViewWithEditHeight.rawValue
        } else if selBtn.tag == 513 {
            backGrdViewFourteen.isHidden = false
            backGrdViewFourteenHeight.constant = viewHeight.symptomsWithEditHeight.rawValue
        }
    }
    
    @IBAction func btnUpdateAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 700 {
            symptomsBackGrdView.isHidden = true
            symptomsHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditOne.isHidden = false
            
            if btntrueOne.isSelected {
                symptoms = checkBox.trueVal.rawValue
            } else if btnfalseOne.isSelected {
                symptoms = checkBox.falseVal.rawValue
            }
            lblEditSymptomsOne.text = symptoms
            
        } else if selBtn.tag == 701 {
            backGrdViewTwo.isHidden = true
            backGrdViewTwoHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditTwo.isHidden = false
            
            dateSymptomsStarted = tfDateSymStarted.text
            lblEditdateSymptomsStartedTwo.text = dateSymptomsStarted
            
        } else if selBtn.tag == 702 {
            backGrdViewThree.isHidden = true
            backGrdViewThreeHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditThree.isHidden = false
            
            if btntrueTwo.isSelected {
                proritizedForTesting  = checkBox.trueVal.rawValue
            } else  if btnfalseTwo.isSelected {
                proritizedForTesting = checkBox.falseVal.rawValue
            }
            lblEditProritizedForTestingThree.text = proritizedForTesting
            
        } else if selBtn.tag == 703 {
            backGrdViewFour.isHidden = true
            backGrdViewFourHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditFour.isHidden = false
            
            if btntrueThree.isSelected {
                firstTimeTesting  = checkBox.trueVal.rawValue
            } else  if btnfalseThree.isSelected {
                firstTimeTesting = checkBox.falseVal.rawValue
            }
            lblEditFirstTimeTestingFour.text = firstTimeTesting
            
        } else if selBtn.tag == 704 {
            backGrdViewFive.isHidden = true
            backGrdViewFiveHeight.constant = viewHeight.fifthViewWithOutEditHeight.rawValue
            btnEditFive.isHidden = false
            
            if btntrueFour.isSelected {
                contactWithAnyOne  = checkBox.trueVal.rawValue
            } else  if btnfalseFour.isSelected {
                contactWithAnyOne = checkBox.falseVal.rawValue
            }
            lblEditContactWithAnyOneFive.text = contactWithAnyOne
            
        } else if selBtn.tag == 705 {
            backGrdViewSix.isHidden = true
            backGrdViewSixHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditSix.isHidden = false
            
            if btntrueFive.isSelected {
                medicalCondition  = checkBox.trueVal.rawValue
            } else  if btnfalseFive.isSelected {
                medicalCondition = checkBox.falseVal.rawValue
            }
            lblEditMedicalConditionSix.text = medicalCondition
            
        } else if selBtn.tag == 706 {
            backGrdViewSeven.isHidden = true
            backGrdViewSevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditSeven.isHidden = false
            
            if btntrueSix.isSelected {
                pregnant  = checkBox.trueVal.rawValue
            } else  if btnfalseSix.isSelected {
                pregnant = checkBox.falseVal.rawValue
            }
            lblEditPregnantSeven.text = pregnant
            
        } else if selBtn.tag == 707 {
            backGrdViewEight.isHidden = true
            backGrdViewEightHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditEight.isHidden = false
            
            if btntrueSeven.isSelected {
                highRiskCategory  = checkBox.trueVal.rawValue
            } else  if btnfalseSeven.isSelected {
                highRiskCategory = checkBox.falseVal.rawValue
            }
            lblEditHighRiskCategoryEight.text = highRiskCategory
            
        } else if selBtn.tag == 708 {
            backGrdViewNine.isHidden = true
            backGrdViewNineHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditNine.isHidden = false
            
            if btntrueEight.isSelected {
                smoker  = checkBox.trueVal.rawValue
            } else  if btnfalseEight.isSelected {
                smoker = checkBox.falseVal.rawValue
            }
            lblEditSmokerNine.text = smoker
            
        } else if selBtn.tag == 709 {
            backGrdViewTen.isHidden = true
            backGrdViewTenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditTen.isHidden = false
            
            if btntrueNine.isSelected {
                primaryCareProvider  = checkBox.trueVal.rawValue
            } else  if btnfalseNine.isSelected {
                primaryCareProvider = checkBox.falseVal.rawValue
            }
            lblEditPrimaryCareProviderTen.text = primaryCareProvider
            
        } else if selBtn.tag == 710 {
            backGrdViewEleven.isHidden = true
            backGrdViewElevenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditEleven.isHidden = false
            
            careProvider = tfCareProvider.text
            lblEditCareProviderEleven.text = careProvider
            
        } else if selBtn.tag == 711 {
            backGrdViewTwelve.isHidden = true
            backGrdViewTwelveHeight.constant = viewHeight.TwelveViewWithOutEditHeight.rawValue
            btnEditTwelve.isHidden = false
            
            addressLineOne = tfAddressLineOne.text
            addressLineTwo =  tfAddressLineTwo.text
            city =  tfCity.text
            state = tfState.text
            zipCode = tfZipCode.text
            
            lblEditAddressOfCareProviderTwelve.text = "\(addressLineOne ?? "") \n \(addressLineTwo ?? "") \n \(city ?? "") \n \(state ?? "") \n \(zipCode ?? "")"
           
        
        } else if selBtn.tag == 712 {
            backGrdViewThirteen.isHidden = true
            backGrdViewThirteenHeight.constant = viewHeight.fifthViewWithOutEditHeight.rawValue
            btnEditThirteen.isHidden = false
            
            phoneNumber = tfPhoneNumber.text
            emailAddress = tfEmailAddress.text
            
            lblEditContactDetailsThirteen.text = "\(phoneNumber ?? "") \n \(emailAddress ?? "")"
           
            
        } else if selBtn.tag == 713 {
            backGrdViewFourteen.isHidden = true
            backGrdViewFourteenHeight.constant = viewHeight.symptomsWithOutEditHeight.rawValue
            btnEditFourteen.isHidden = false
            
            if btntrueTen.isSelected {
                careFacility  = checkBox.trueVal.rawValue
            } else  if btnfalseTen.isSelected {
                careFacility = checkBox.falseVal.rawValue
            }
            lblEditCareFacilityFourteen.text = careFacility
        }
    }

    
    // MARK: - Custom Button Actions
    @IBAction func selectioBox(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 100 {
            
            symptoms = "Yes"
            btnfalseOne.isSelected = false
            btntrueOne.isSelected = true
            
        } else if selBtn.tag == 101 {
            
            symptoms = "No"
            btnfalseOne.isSelected = true
            btntrueOne.isSelected = false
            
        } else if selBtn.tag == 102 {
            
            proritizedForTesting = "Yes"
            btnfalseTwo.isSelected = false
            btntrueTwo.isSelected = true
            
        } else if selBtn.tag == 103 {
            
            proritizedForTesting = "No"
            btnfalseTwo.isSelected = true
            btntrueTwo.isSelected = false
            
        } else if selBtn.tag == 104 {
            
            firstTimeTesting = "Yes"
            btnfalseThree.isSelected = false
            btntrueThree.isSelected = true
            
        } else if selBtn.tag == 105 {
            
            firstTimeTesting = "No"
            btnfalseThree.isSelected = true
            btntrueThree.isSelected = false
            
        } else if selBtn.tag == 106 {
            
            contactWithAnyOne = "Yes"
            btnfalseFour.isSelected = false
            btntrueFour.isSelected = true
            
        } else if selBtn.tag == 107 {
            
            contactWithAnyOne = "No"
            btnfalseFour.isSelected = true
            btntrueFour.isSelected = false
            
        } else if selBtn.tag == 108 {
            
            medicalCondition = "Yes"
            btnfalseFive.isSelected = false
            btntrueFive.isSelected = true
            
        } else if selBtn.tag == 109 {
            
            medicalCondition = "No"
            btnfalseFive.isSelected = true
            btntrueFive.isSelected = false
            
        } else if selBtn.tag == 110 {
            
            pregnant = "Yes"
            btnfalseSix.isSelected = false
            btntrueSix.isSelected = true
            
        } else if selBtn.tag == 111 {
            
            pregnant = "No"
            btnfalseSix.isSelected = true
            btntrueSix.isSelected = false
            
        } else if selBtn.tag == 112 {
            
            highRiskCategory = "Yes"
            btnfalseSeven.isSelected = false
            btntrueSeven.isSelected = true
            
        } else if selBtn.tag == 113 {
            
            highRiskCategory = "No"
            btnfalseSeven.isSelected = true
            btntrueSeven.isSelected = false
            
        } else if selBtn.tag == 114 {
            
            smoker = "Yes"
            btnfalseEight.isSelected = false
            btntrueEight.isSelected = true
            
        } else if selBtn.tag == 115 {
            
            smoker = "No"
            btnfalseEight.isSelected = true
            btntrueEight.isSelected = false
            
        } else if selBtn.tag == 116 {
            
            primaryCareProvider = "Yes"
            btnfalseNine.isSelected = false
            btntrueNine.isSelected = true
            
        } else if selBtn.tag == 117 {
            
            primaryCareProvider = "No"
            btnfalseNine.isSelected = true
            btntrueNine.isSelected = false
            
        } else if selBtn.tag == 118 {
            
            careFacility = "Yes"
            btnfalseTen.isSelected = false
            btntrueTen.isSelected = true
            
        } else if selBtn.tag == 119 {
            
            careFacility = "No"
            btnfalseTen.isSelected = true
            btntrueTen.isSelected = false
            
        }
    }
}

extension RegisterScreenConfirm: JBCalendarViewControllerDelegate {
    func calendarViewControllerDateChanged(_ calendarViewController: JBCalendarViewController) {
        print(calendarViewController.date)
        tfDateSymStarted.text = calendarViewController.date.convertToDateFormat()
        calendarViewController.dismiss(animated: true, completion: nil)
    }
    
    func calendarViewControllerWillDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
    func calendarViewControllerDidDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
  
}
