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
    
    
    @IBOutlet weak var backGndView:UIView!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!


    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 18),
        .foregroundColor: UIColor.Citygo.formsubtitlesnotselected,
          .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isLogin = UserData.shared.getIsUserLogin()
        backGndView.isHidden = true
        if isLogin ?? false {
           
            checkConnectivityBackUpData()
            backGndView.isHidden = false
        }
        
//        MyScheduleTestsViewController
        // Do any additional setup after loading the view.
        btnGetStarted.btnEnable(boolVal: true)
        btnHowItWorks.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
      

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)

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
    
    func showOfflineMessage(title: String, msg: String) {
       
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { _ in
           
        }
      
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkConnectivityBackUpData() {
        
        if Reachability.isConnectedToNetwork() {
            
            // let authUrl = Endpoint.accountDetails+"s.shetty@gmail.com"
            let authUrl = "https://covid19api.sutherlandglobal.com/api/Authentication?EmailAddress=\(UserData.shared.getUserName() )&Password=\(UserData.shared.getPassword())"
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getLogin(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.isSuccess ?? false {
                        let loginVal = dashboads.Data?[0]
                        if loginVal?.Message == "Valid" {
                            self.backGndView.isHidden = true
                            let usernames = loginVal?.UserName?.components(separatedBy: " ")
                            SingletonData.shared.firstNamePatient = String(usernames?[0] ?? "")
                            SingletonData.shared.lastNamePatient = String(usernames?[1] ?? "")
                           
                            UserData.shared.setIsUserLogin(boolVal: true)
                           
                            SingletonData.shared.email = UserData.shared.getUserName()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "MyScheduleTestsViewController") as! MyScheduleTestsViewController
                            self.navigationController?.pushViewController(controller, animated: false)
                            
                        } else {
                            self.backGndView.isHidden = false
                            self.showOfflineMessage(title: "Invalid username or password", msg: "")
                        }
                        
                    } else {
                        self.backGndView.isHidden = false
                        self.showOfflineMessage(title: "Invalid username or password", msg: "")
                    }
                       
                case .failure( _):
                    self.backGndView.isHidden = false
                    //something went wrong, print the error.
                    self.showOfflineMessage(title: Endpoint.errorMessage, msg: "")
                }
            })
        } else {
            self.showOfflineMessage(title: "Network Error", msg: "Unable to access the Network")
        }
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
