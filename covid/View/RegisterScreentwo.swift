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
    
    @IBOutlet weak var medicalConditionTitle:UILabel!
    @IBOutlet weak var pregnantTitle:UILabel!
    @IBOutlet weak var highRiskCategoryTitle:UILabel!
    @IBOutlet weak var smokerTitle:UILabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBOutlet weak var pregnantBackView: UIView!
    @IBOutlet weak var pregnantBackViewHeight: NSLayoutConstraint!
    
    
    var medicalCondition:String? = ""
    var pregnant:String? = ""
    var highRiskCategory:String? = ""
    var smoker:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        self.setViewTitles()
        
        if SingletonData.shared.gender?.lowercased() == "female" {
            pregnantBackView.isHidden = false
            pregnantBackViewHeight.constant = 100
        } else {
            pregnantBackView.isHidden = true
            pregnantBackViewHeight.constant = 0
        }
        
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }
    func setViewTitles(){
        self.medicalConditionTitle.text = titles.medicalCondition
        self.pregnantTitle.text = titles.pregnant
        self.highRiskCategoryTitle.text = titles.highRiskCategory
        self.smokerTitle.text = titles.smoker
        
        if SingletonData.shared.StatusCode == 0 {
            medicalCondition = SingletonData.shared.medicalCondition
            if medicalCondition == checkBoxInt.trueVal.rawValue {
                btnMedicalConditionTrue.isSelected = true
            } else  if medicalCondition == checkBoxInt.falseVal.rawValue {
                btnMedicalConditionfalse.isSelected = true
            }
            pregnant = SingletonData.shared.pregnant
            if pregnant == checkBoxInt.trueVal.rawValue {
                btnPregnantTrue.isSelected = true
            } else  if pregnant == checkBoxInt.falseVal.rawValue  {
                btnPregnantfalse.isSelected = true
            }
            highRiskCategory = SingletonData.shared.highRiskCategory
            if highRiskCategory == checkBoxInt.trueVal.rawValue {
                btnHighRiskCategoryTrue.isSelected = true
            } else if highRiskCategory == checkBoxInt.falseVal.rawValue {
                btnHighRiskCategoryfalse.isSelected = true
            }
            smoker = SingletonData.shared.smoker
            if smoker == checkBoxInt.trueVal.rawValue {
                btnSmokerTrue.isSelected = true
            } else if smoker == checkBoxInt.falseVal.rawValue {
                btnSmokerfalse.isSelected = true
            }
            btnNext.btnEnable(boolVal: true)
        }
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
            medicalCondition = "1"
            btnMedicalConditionfalse.isSelected = false
            btnMedicalConditionTrue.isSelected = true
        } else if selBtn.tag == 101 {
            medicalCondition = "0"
            btnMedicalConditionfalse.isSelected = true
            btnMedicalConditionTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnPregnantAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 102 {
            pregnant = "1"
            btnPregnantfalse.isSelected = false
            btnPregnantTrue.isSelected = true
        } else if selBtn.tag == 103 {
            pregnant = "0"
            btnPregnantfalse.isSelected = true
            btnPregnantTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnHighRiskCategoryAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 104 {
            highRiskCategory = "1"
            btnHighRiskCategoryfalse.isSelected = false
            btnHighRiskCategoryTrue.isSelected = true
        } else if selBtn.tag == 105 {
            highRiskCategory = "0"
            btnHighRiskCategoryfalse.isSelected = true
            btnHighRiskCategoryTrue.isSelected = false
        }
        checkAllTheFeilds()
    }
    @IBAction func btnSmokerAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        if selBtn.tag == 106 {
            smoker = "1"
            btnSmokerfalse.isSelected = false
            btnSmokerTrue.isSelected = true
        } else if selBtn.tag == 107 {
            smoker = "0"
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
        checkConnectivity()
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
    
    func showsAlertWithoutWhiteBg( titleVal : String , messageVal: String) {
        let alertController = UIAlertController(title: titleVal, message: messageVal, preferredStyle: .alert)
        let trueAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(trueAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkConnectivity() {
        
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? ""
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"Medical_Condition\":\"\(medicalCondition ?? "")\",\"Pregnant\":\"\(pregnant ?? "")\",\"Highrisk_Category\":\"\(highRiskCategory ?? "")\",\"Smoke\":\"\(smoker ?? "")\"}'}"
            print("email verification: \(dic)")
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterScreenThree") as! RegisterScreenThree
                        self.navigationController?.pushViewController(controller, animated: false)
                    } else {
                        self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                    }
                    
                case .failure( _):
                    //something went wrong, print the error.
                    self.showsAlertWithoutWhiteBg(titleVal: Endpoint.errorMessage, messageVal: "")
                }
            })
        } else {
            self.showsAlertWithoutWhiteBg(titleVal: "Network Error", messageVal: "Unable to access the Network")
        }
    }

}
