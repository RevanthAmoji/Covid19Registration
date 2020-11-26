//
//  ViewController.swift
//  covid
//
//  Created by venkata baisani on 16/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnGetStarted: SutherlandButton!
    @IBOutlet weak var btnHowItWorks: SutherlandButton!
    @IBOutlet weak var btnAlreadyAccount: UIButton!
    
    @IBOutlet weak var titlelbl: SutherlandLabel!
    @IBOutlet weak var subTitlelbl: SutherlandLabel!
    @IBOutlet weak var languageTF: SutherlandTextField!

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
        titlelbl.localizableKey = "choose_language_title"
        subTitlelbl.localizableKey = "choose_language_subtitle"
        btnGetStarted.localizableKey = "choose_language_getstarted"
        btnHowItWorks.localizableKey = "choose_language_itworks"
        var localString = "Alreay have an account?"
        if SingletonUI.shared.selectedLanguage == "Español" {
            localString = "¿Ya tienes una cuenta?"
        }
        let attributeString = NSMutableAttributedString(string: localString,
                                                            attributes: yourAttributes)
        btnAlreadyAccount.setAttributedTitle(attributeString, for: .normal)
    }
    
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

