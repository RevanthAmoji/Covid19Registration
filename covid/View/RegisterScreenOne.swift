//
//  RegisterScreenOne.swift
//  covid
//
//  Created by venkata baisani on 22/11/20.
//

import UIKit
import JBCalendarDatePicker

class RegisterScreenOne: UIViewController {
    
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
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

    }
  
    // MARK: - Custom Button Actions
    @IBAction func btnSymptomsAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 100 {
            symptoms = "Yes"
            btnSymptomsfalse.isSelected = false
            btnSymptomsTrue.isSelected = true
        } else if selBtn.tag == 101 {
            symptoms = "No"
            btnSymptomsfalse.isSelected = true
            btnSymptomsTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnProritizedForTestingAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 102 {
            proritizedForTesting = "Yes"
            btnProritizedForTestingfalse.isSelected = false
            btnProritizedForTestingTrue.isSelected = true
        } else if selBtn.tag == 103 {
            proritizedForTesting = "No"
            btnProritizedForTestingfalse.isSelected = true
            btnProritizedForTestingTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnFirstTimeTestingAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 104 {
            firstTimeTesting = "Yes"
            btnFirstTimeTestingfalse.isSelected = false
            btnFirstTimeTestingTrue.isSelected = true
        } else if selBtn.tag == 105 {
            firstTimeTesting = "No"
            btnFirstTimeTestingfalse.isSelected = true
            btnFirstTimeTestingTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnContactWithAnyOneAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 106 {
            contactWithAnyOne = "Yes"
            btnContactWithAnyOnefalse.isSelected = false
            btnContactWithAnyOneTrue.isSelected = true
        } else if selBtn.tag == 107 {
            contactWithAnyOne = "No"
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
