//
//  RegisterScreenOne.swift
//  covid
//
//  Created by venkata baisani on 22/11/20.
//

import UIKit
import JBCalendarDatePicker

class RegisterScreenOne: UIViewController,ProgressBarShower {
    
    @IBOutlet weak var scrollViewReg: UIScrollView!
    
    @IBOutlet weak var btnSymptomsTrue: UIButton!
    @IBOutlet weak var btnSymptomsfalse: UIButton!
    
    @IBOutlet weak var tfDateSymStarted: UITextField!
    @IBOutlet weak var btnDateSym: UIButton!
    @IBOutlet weak var btnDateSymBackGndView: UIView!
    
    @IBOutlet weak var btnProritizedForTestingTrue: UIButton!
    @IBOutlet weak var btnProritizedForTestingfalse: UIButton!
    
    @IBOutlet weak var btnFirstTimeTestingTrue: UIButton!
    @IBOutlet weak var btnFirstTimeTestingfalse: UIButton!
    
    @IBOutlet weak var btnContactWithAnyOneTrue: UIButton!
    @IBOutlet weak var btnContactWithAnyOnefalse: UIButton!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    @IBOutlet weak var symptomsTitle:UILabel!
    @IBOutlet weak var dateSymStartedTitle:UILabel!
    @IBOutlet weak var proritizedForTestingTitle:UILabel!
    @IBOutlet weak var firstTimeTestingTitle:UILabel!
    @IBOutlet weak var contactWithAnyOneTitle:UILabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    var symptoms:String? = ""
    var proritizedForTesting:String? = ""
    var firstTimeTesting:String? = ""
    var contactWithAnyOne:String? = ""
    
    var datePicker: JBDatePickerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        self.setViewTitles()
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

    }
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
   
    func setViewTitles(){
        
        print(SingletonData.shared.relationName as Any)
        
        if SingletonData.shared.relationNumber == SingletonData.shared.myselfRelationVal {
            
            self.symptomsTitle.text = titles.symptoms_myslef
            self.dateSymStartedTitle.text = titles.dateSymptomsStarted_myslef
            self.proritizedForTestingTitle.text = titles.proritizedForTesting_myslef
            self.firstTimeTestingTitle.text = titles.firstTimeTesting_myslef
            self.contactWithAnyOneTitle.text = titles.contactWithAnyOne_myslef
            
        } else {
            
            self.symptomsTitle.text = titles.symptoms
            self.dateSymStartedTitle.text = titles.dateSymptomsStarted
            self.proritizedForTestingTitle.text = titles.proritizedForTesting
            self.firstTimeTestingTitle.text = titles.firstTimeTesting
            self.contactWithAnyOneTitle.text = titles.contactWithAnyOne
        }
    
        if SingletonData.shared.StatusCode == 0 {
            
            symptoms = SingletonData.shared.symptoms
            if symptoms == checkBoxInt.trueVal.rawValue {
                btnSymptomsTrue.isSelected = true
            } else if symptoms == checkBoxInt.falseVal.rawValue {
                btnSymptomsfalse.isSelected = true
            }
            tfDateSymStarted.text = SingletonData.shared.dateSymptomsStarted
            
            proritizedForTesting = SingletonData.shared.proritizedForTesting
            if proritizedForTesting == checkBoxInt.trueVal.rawValue {
                btnProritizedForTestingTrue.isSelected = true
            } else if proritizedForTesting == checkBoxInt.falseVal.rawValue {
                btnProritizedForTestingfalse.isSelected = true
            }
            firstTimeTesting = SingletonData.shared.firstTimeTesting
            if firstTimeTesting == checkBoxInt.trueVal.rawValue {
                btnFirstTimeTestingTrue.isSelected = true
            } else  if firstTimeTesting == checkBoxInt.falseVal.rawValue {
                btnFirstTimeTestingfalse.isSelected = true
            }
            contactWithAnyOne = SingletonData.shared.contactWithAnyOne
            if contactWithAnyOne == checkBoxInt.trueVal.rawValue {
                btnContactWithAnyOneTrue.isSelected = true
            } else  if contactWithAnyOne == checkBoxInt.falseVal.rawValue {
                btnContactWithAnyOnefalse.isSelected = true
            }
            btnNext.btnEnable(boolVal: true)
        }
    }
  
    // MARK: - Custom Button Actions
    @IBAction func btnSymptomsAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 100 {
            symptoms = "1"
            btnSymptomsfalse.isSelected = false
            btnSymptomsTrue.isSelected = true
        } else if selBtn.tag == 101 {
            symptoms = "0"
            btnSymptomsfalse.isSelected = true
            btnSymptomsTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnProritizedForTestingAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 102 {
            proritizedForTesting = "1"
            btnProritizedForTestingfalse.isSelected = false
            btnProritizedForTestingTrue.isSelected = true
        } else if selBtn.tag == 103 {
            proritizedForTesting = "0"
            btnProritizedForTestingfalse.isSelected = true
            btnProritizedForTestingTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnFirstTimeTestingAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 104 {
            firstTimeTesting = "1"
            btnFirstTimeTestingfalse.isSelected = false
            btnFirstTimeTestingTrue.isSelected = true
        } else if selBtn.tag == 105 {
            firstTimeTesting = "0"
            btnFirstTimeTestingfalse.isSelected = true
            btnFirstTimeTestingTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnContactWithAnyOneAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 106 {
            contactWithAnyOne = "1"
            btnContactWithAnyOnefalse.isSelected = false
            btnContactWithAnyOneTrue.isSelected = true
        } else if selBtn.tag == 107 {
            contactWithAnyOne = "0"
            btnContactWithAnyOnefalse.isSelected = true
            btnContactWithAnyOneTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    
    @IBAction func buttonCalPressed(_ sender: Any) {
        let calendarPicker = JBCalendarViewController()
        calendarPicker.popoverPresentationController?.sourceView = btnDateSymBackGndView
        calendarPicker.delegate = self
        // Configure the calendar's properties
        present(calendarPicker, animated: true, completion: nil)
    }
 
    @IBAction func btnNexgt(_ sender: Any) {
       
        SingletonData.shared.symptoms = symptoms
        SingletonData.shared.proritizedForTesting = proritizedForTesting
        SingletonData.shared.firstTimeTesting = firstTimeTesting
        SingletonData.shared.contactWithAnyOne = contactWithAnyOne
        SingletonData.shared.dateSymptomsStarted = tfDateSymStarted.text
        
        checkConnectivity()
    }
    
    func checkAllTheFeilds() {
        var errorMessage = ""
        if (symptoms?.count == 0 || symptoms == nil) || (proritizedForTesting?.count == 0 || proritizedForTesting == nil) || (firstTimeTesting?.count == 0 || firstTimeTesting == nil) || (contactWithAnyOne?.count == 0 || contactWithAnyOne == nil) {
            errorMessage = "Please select all the priorities"
        }  else if tfDateSymStarted.text?.count == 0 || tfDateSymStarted == nil {
            errorMessage = "Please enter Date Sym Started"
        } else {
            btnNext.btnEnable(boolVal: true)
            return
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
        
        self.showProgressBar()
        
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"HasCorona_symptoms\":\"\(symptoms ?? "")\",\"Symptoms_StartedDate\":\"\(tfDateSymStarted.text ?? "")\",\"Proritized_Testing\":\"\(proritizedForTesting ?? "")\",\"FirstTime_Test\":\"\(firstTimeTesting ?? "")\",\"Contact_Last15days\":\"\(contactWithAnyOne ?? "")\"}'}"
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
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterScreentwo") as! RegisterScreentwo
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

}

extension RegisterScreenOne: JBCalendarViewControllerDelegate {
    func calendarViewControllerDateChanged(_ calendarViewController: JBCalendarViewController) {
        print(calendarViewController.date)
        tfDateSymStarted.text = calendarViewController.date.convertToDateFormat()
        calendarViewController.dismiss(animated: true, completion: nil)
        checkAllTheFeilds()
    }
    
    func calendarViewControllerWillDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
    func calendarViewControllerDidDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
  
}

extension Date {
    func convertToDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let convertedString = formatter.string(from: self)

        return convertedString
    }
}
