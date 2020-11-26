//
//  RegisterScreentwo.swift
//  covid
//
//  Created by venkata baisani on 23/11/20.
//

import UIKit

class RegisterScreentwo: UIViewController {
    
    @IBOutlet weak var btnMedicalConditionTrue: UIButton!
    @IBOutlet weak var btnMedicalConditionfalse: UIButton!
   
    @IBOutlet weak var btnPregnantTrue: UIButton!
    @IBOutlet weak var btnPregnantfalse: UIButton!
    
    @IBOutlet weak var btnHighRiskCategoryTrue: UIButton!
    @IBOutlet weak var btnHighRiskCategoryfalse: UIButton!
    
    @IBOutlet weak var btnSmokerTrue: UIButton!
    @IBOutlet weak var btnSmokerfalse: UIButton!
    
    @IBOutlet weak var btnNext: SutherlandButton!
    
    var medicalCondition:String? = ""
    var pregnant:String? = ""
    var highRiskCategory:String? = ""
    var smoker:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
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
    @IBAction func btnMedicalConditionAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 100 {
            medicalCondition = "Yes"
            btnMedicalConditionfalse.isSelected = false
            btnMedicalConditionTrue.isSelected = true
        } else if selBtn.tag == 101 {
            medicalCondition = "No"
            btnMedicalConditionfalse.isSelected = true
            btnMedicalConditionTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnPregnantAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 102 {
            pregnant = "Yes"
            btnPregnantfalse.isSelected = false
            btnPregnantTrue.isSelected = true
        } else if selBtn.tag == 103 {
            pregnant = "No"
            btnPregnantfalse.isSelected = true
            btnPregnantTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnHighRiskCategoryAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 104 {
            highRiskCategory = "Yes"
            btnHighRiskCategoryfalse.isSelected = false
            btnHighRiskCategoryTrue.isSelected = true
        } else if selBtn.tag == 105 {
            highRiskCategory = "No"
            btnHighRiskCategoryfalse.isSelected = true
            btnHighRiskCategoryTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnSmokerAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 106 {
            smoker = "Yes"
            btnSmokerfalse.isSelected = false
            btnSmokerTrue.isSelected = true
        } else if selBtn.tag == 107 {
            smoker = "No"
            btnSmokerfalse.isSelected = true
            btnSmokerTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    
    @IBAction func btnNexgt(_ sender: Any) {
        SingletonData.shared.medicalCondition = medicalCondition
        SingletonData.shared.pregnant = pregnant
        SingletonData.shared.highRiskCategory = highRiskCategory
        SingletonData.shared.smoker = smoker
    }
    func checkAllTheFeilds() {
        var errorMessage = ""
        if (medicalCondition?.count == 0 || medicalCondition == nil) || (pregnant?.count == 0 || pregnant == nil) || (highRiskCategory?.count == 0 || highRiskCategory == nil) || (smoker?.count == 0 || smoker == nil) {
            errorMessage = "Please select all the priorities"
        }  else {
            btnNext.btnEnable(boolVal: true)
            return
        }
        //self.showsAlertWithoutWhiteBg(titleVal: "", messageVal: errorMessage)
        print(errorMessage)
    }
}
