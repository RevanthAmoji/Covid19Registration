//
//  RegisterPortalThree.swift
//  covid
//
//  Created by venkata baisani on 14/12/20.
//

import UIKit

class RegisterPortalThree: UIViewController, ProgressBarShower{
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var btnSelAgree:UIButton!
    
    @IBOutlet weak var tfInsuranceProvider: SutherlandTextField!
    @IBOutlet weak var tfPolicyNumber: SutherlandTextField!
    @IBOutlet weak var tfPolicyHolderName: SutherlandTextField!
    
    @IBOutlet weak var policyBackGndView: UIView!
    @IBOutlet weak var policyBackGndViewHeight: NSLayoutConstraint!
    @IBOutlet weak var uploadFormBackGndView, backGndViewIdentification:UIView!
    @IBOutlet weak var uploadFormBackGndViewwHeight: NSLayoutConstraint!
    
    var selAgreeStr:String? = "0"
    
    @IBOutlet weak var tfIdentification: SutherlandTextField!
    @IBOutlet weak var tfIdentificationDummy: SutherlandTextField!
    @IBOutlet weak var tfAttached: SutherlandTextField!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var scrollViewReg: UIScrollView!

    @IBOutlet weak var identificationTableView: UITableView!
    
    var ageList:[RelationModel] = []
    
    var identification:String = "-1"
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        btnSelAgree.isSelected = false
        uploadFormBackGndView.isHidden = true
        uploadFormBackGndViewwHeight.constant = 0 //140
        
        btnNext.btnEnable(boolVal: false)
        
        //portalFinalTitle
        lblSubTitle.text = titles.portalFinalTitle
        
        if SingletonData.shared.StatusCode == 0 {
            
            tfInsuranceProvider.text =  SingletonData.shared.insuranceProvider
            tfPolicyNumber.text = SingletonData.shared.policyNumber
            tfPolicyHolderName.text = SingletonData.shared.policyHolderName
            tfIdentification.text = SingletonData.shared.identification
            identification = SingletonData.shared.identificationVal ?? "-1"
            btnNext.btnEnable(boolVal: true)
        }
        
        checkConnectivityIdentification()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSelAgreeAction(_ sender: Any) {
        let selBtn = sender as! UIButton
        
        if selBtn.isSelected {
            
            selAgreeStr = "0"
            btnSelAgree.isSelected = false
            
            uploadFormBackGndView.isHidden = true
            uploadFormBackGndViewwHeight.constant = 0 //140
            
            policyBackGndView.isHidden = false
            policyBackGndViewHeight.constant = 278 //278
            
        } else {
            
            selAgreeStr = "1"
            btnSelAgree.isSelected = true
            
            uploadFormBackGndView.isHidden = true
            uploadFormBackGndViewwHeight.constant = 0 //140
            
            policyBackGndView.isHidden = true
            policyBackGndViewHeight.constant = 0 //278
            
        }
        checkAllTheFeilds()
    }
   
    func checkConnectivityIdentification() {
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.identificationType
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getRelationData(url: authUrl, completion: { [self]
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.count != 0 {
                        
                        self.ageList = dashboads
                        
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
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 50, right: 0)
        self.scrollViewReg.contentInset = contentInsets
        self.scrollViewReg.scrollIndicatorInsets = contentInsets
    }
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        
        SingletonData.shared.insuranceProvider = tfInsuranceProvider.text
        SingletonData.shared.policyNumber = tfPolicyNumber.text
        SingletonData.shared.policyHolderName = tfPolicyHolderName.text
        SingletonData.shared.identification = tfIdentification.text
        SingletonData.shared.identificationVal = identification
        SingletonData.shared.identificationAttached = tfAttached.text
        
        checkConnectivity()
    }
    @IBAction func uploadNewResumeAction(_ sender: Any) {

     let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)

    // let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
        

     documentPicker.delegate = self
     present(documentPicker, animated: true, completion: nil)
 }
    func checkConnectivity() {
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? "rev1@test.com"
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"Patient_InsuranceName\":\"\(tfInsuranceProvider.text ?? "")\",\"Patient_Policyno\":\"\(tfPolicyNumber.text ?? "")\",\"Patient_PolicyholderName\":\"\(tfPolicyHolderName.text ?? "")\",\"Patient_hasvalididentification\":\"\("1")\",\"Patient_IdentificationName\":\"\(identification)\",\"FileContent\":\"\(tfAttached.text ?? "")\"}'}"
            
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
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterPortalConfirm") as! RegisterPortalConfirm
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

    func showsAlertWithoutWhiteBg( titleVal : String , messageVal: String) {
        let alertController = UIAlertController(title: titleVal, message: messageVal, preferredStyle: .alert)
        let trueAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(trueAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkAllTheFeilds() {
        //tfIdentification.text
        var errorMessage = ""
        if !policyBackGndView.isHidden {
            btnNext.btnEnable(boolVal: false)
            
            if tfPolicyNumber.text?.count == 0 || tfPolicyNumber == nil {
                errorMessage = "Please enter patient last name"
            } else if tfInsuranceProvider.text?.count == 0 || tfInsuranceProvider == nil {
                errorMessage = "Please enter patient last name"
            } else if tfPolicyHolderName.text?.count == 0 || tfPolicyHolderName == nil {
                errorMessage = "Please select consent from the patient to register on their behalf"
            } else if tfIdentification.text?.count == 0 || tfIdentification == nil {
                errorMessage = "Please select consent from the patient to register on their behalf"
            } else {
                btnNext.btnEnable(boolVal: true)
                return
            }
            print(errorMessage)
        } else {
            
            if tfIdentification.text?.count == 0 || tfIdentification == nil {
                errorMessage = "Please select consent from the patient to register on their behalf"
            } else {
                btnNext.btnEnable(boolVal: true)
                return
            }
            print(errorMessage)
        }
    }
    
    @IBAction func dropdownBtnRaceAction(_ sender: Any) {
    
        self.heighlighBoarderColorIdentification(boolVal: true)
        identificationTableView.reloadData()
    }
    
    func heighlighBoarderColorIdentification(boolVal: Bool){
 
        backGndViewIdentification.isHidden = !boolVal
        
        if boolVal {
            tfIdentification.layer.borderColor = UIColor.Citygo.redColor.cgColor
            tfIdentificationDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            tfIdentification.layer.borderColor = UIColor.clear.cgColor
            tfIdentificationDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor

        }
        
        tfIdentification.layer.borderWidth = 0.4
        tfIdentification.layer.cornerRadius = 5.0
        
        tfIdentificationDummy.layer.borderWidth = 0.4
        tfIdentificationDummy.layer.cornerRadius = 5.0
    }
}

extension RegisterPortalThree: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == tfPolicyNumber  {
            
            if textField.text?.count == 0 {
                tfPolicyNumber.showBoaderColor(isEnable:true)
            } else {
                tfPolicyNumber.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfInsuranceProvider  {
            
            if textField.text?.count == 0 {
                tfInsuranceProvider.showBoaderColor(isEnable:true)
            } else {
                tfInsuranceProvider.showBoaderColor(isEnable:false)
            }
        
        } else if textField == tfPolicyHolderName  {
            
            if textField.text?.count == 0 {
                tfPolicyHolderName.showBoaderColor(isEnable:true)
            } else {
                tfPolicyHolderName.showBoaderColor(isEnable:false)
            }
        
        }
        checkAllTheFeilds()
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}

extension RegisterPortalThree: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ageList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesCell", for: indexPath) as! LanguagesCell
        cell.titleLbl.text = ageList[indexPath.row].Text
    
        cell.contentView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        cell.titleLbl.textColor = UIColor.Citygo.formsubtitlesnotselected
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.heighlighBoarderColorIdentification(boolVal: false)
        tfIdentification.text = ageList[indexPath.row].Text
        tfIdentificationDummy.text = ageList[indexPath.row].Text
        identification = ageList[indexPath.row].Value ?? ""
         
        if policyBackGndView.isHidden {
           btnNext.btnEnable(boolVal: true)
        } else {
           checkAllTheFeilds()
        }
    }
}

extension RegisterPortalThree: UIDocumentPickerDelegate{

      func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {

                let cico = url as URL
                print(cico)
                print(url)

                print(url.lastPathComponent)

                print(url.pathExtension)

               }
   }
