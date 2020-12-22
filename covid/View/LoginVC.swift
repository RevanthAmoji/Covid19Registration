//
//  LoginVC.swift
//  covid
//
//  Created by venkata baisani on 22/12/20.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var btnGetStarted: SutherlandButton!
    @IBOutlet weak var btnHowItWorks: SutherlandButton!
    @IBOutlet weak var btnAlreadyAccount: UIButton!
    
    @IBOutlet weak var lblUserName: SutherlandLabel!
    @IBOutlet weak var lblPassword: SutherlandLabel!
    @IBOutlet weak var languageTF: SutherlandTextField!
    
    @IBOutlet weak var tfEmail: SutherlandTextField!
    @IBOutlet weak var tfPassword: SutherlandTextField!
    
    

    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 18),
        .foregroundColor: UIColor.Citygo.formsubtitlesnotselected,
          .underlineStyle: NSUnderlineStyle.single.rawValue]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnGetStarted.btnEnable(boolVal: true)
        btnHowItWorks.btnHover(boolVal: true)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languageTF.text = SingletonUI.shared.selectedLanguage
        self.setDynamicText()
    }
    
    func setDynamicText() {
      
        let localString = "Forgot password?"
        let attributeString = NSMutableAttributedString(string: localString,
                                                            attributes: yourAttributes)
        btnAlreadyAccount.setAttributedTitle(attributeString, for: .normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnGetStartedStarted(_ sender: Any) {
        
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        
        self.loadPaymentInformationScreen()
    }
    
    @IBAction func dropdownButtonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LanguagesVC") as! LanguagesVC
       
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(controller, animated: false)
    }
     
    func loadPaymentInformationScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
       
        self.navigationController?.pushViewController(controller, animated: false)
    }
}
