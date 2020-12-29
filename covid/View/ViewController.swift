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
        let isLogin = UserData.shared.getIsUserLogin()
        if isLogin ?? false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MyScheduleTestsViewController") as! MyScheduleTestsViewController
            self.navigationController?.pushViewController(controller, animated: false)
            SingletonData.shared.email = UserData.shared.getUserName()
        }
        
//        MyScheduleTestsViewController
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

extension UITextView {


func hyperLink(originalText: String, hyperLink: String, urlString: String) {

    let style = NSMutableParagraphStyle()
    style.alignment = .left

    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
    let fullRange = NSMakeRange(0, attributedOriginalText.length)
   
    attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value:style, range: fullRange)
    attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: fullRange)
    attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15), range: fullRange)

    attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)

    self.linkTextAttributes = [
        .font: UIFont.systemFont(ofSize: 18),
      .foregroundColor: UIColor.systemBlue,
        .underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
    
    self.tintColor = UIColor.red
    self.attributedText = attributedOriginalText
}
}
