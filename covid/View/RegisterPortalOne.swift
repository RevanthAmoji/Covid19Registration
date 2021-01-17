//
//  RegisterPortalOne.swift
//  covid
//
//  Created by venkata baisani on 11/12/20.
//

import UIKit
import JBCalendarDatePicker

class RegisterPortalOne: UIViewController , ProgressBarShower{
    
    @IBOutlet weak var tfDateSymStarted: SutherlandTextField!
    @IBOutlet weak var btnDateSym: UIButton!
    @IBOutlet weak var btnDateSymBackGndView: UIView!
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    @IBOutlet weak var tfAge: SutherlandTextField!
    @IBOutlet weak var tfAgeDummy: SutherlandTextField!
    
    @IBOutlet weak var tfRace: SutherlandTextField!
    @IBOutlet weak var tfRaceDummy: SutherlandTextField!
    
    @IBOutlet weak var backGndViewAge: UIView!
    @IBOutlet weak var backGndViewRace: UIView!
    
    var ageList:[RelationModel] = []
    var raceList:[RelationModel] = []
    
    @IBOutlet weak var ageTableView: UITableView!
    @IBOutlet weak var raceTableView: UITableView!
    
    @IBOutlet weak var lblTitle:UILabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    var gender:String = "-1"
    var race:String = "-1"
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerBackGndview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerBackGndview.isHidden = true
        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        lblTitle.text = titles.portalOneTitle
        if SingletonData.shared.StatusCode == 0 {
            tfDateSymStarted.text = SingletonData.shared.dateOfBirth
            gender = SingletonData.shared.genderVal ?? "-1"
            tfAge.text =  SingletonData.shared.gender
            tfAgeDummy.text =  SingletonData.shared.gender
            tfRace.text = SingletonData.shared.race
            tfRaceDummy.text = SingletonData.shared.race
            race = SingletonData.shared.raceVal ?? "-1"
            btnNext.btnEnable(boolVal: true)
        }
        // Do any additional setup after loading the view.
        self.checkConnectivityGender()
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }
    /*
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        tfDateSymStarted.inputAccessoryView = toolbar
              tfDateSymStarted.inputView = datePicker
        self.view.bringSubviewToFront(datePicker)
        
    }

      @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "MM/dd/YYYY"
        tfDateSymStarted.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    
    */
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func dropdownBtnAgeAction(_ sender: Any) {
    
        self.heighlighBoarderColorAge(boolVal: true)
        ageTableView.reloadData()
    }
    
    @IBAction func dropdownBtnRaceAction(_ sender: Any) {
    
        self.heighlighBoarderColorRace(boolVal: true)
        raceTableView.reloadData()
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        datePickerBackGndview.isHidden = true
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        datePickerBackGndview.isHidden = true
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        tfDateSymStarted.text = formatter.string(from: datePicker.date)
        btnNext.btnEnable(boolVal: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        SingletonData.shared.dateOfBirth = tfDateSymStarted.text
        SingletonData.shared.genderVal = gender
        SingletonData.shared.gender = tfAge.text
        SingletonData.shared.race = tfRace.text
        SingletonData.shared.raceVal = race
        
        checkConnectivity()
    }
    
    func checkConnectivity() {
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
            let email = SingletonData.shared.email ?? "rev1@test.com"
            let dic = "{\"EmailAddress\":\"\(email)\",\"param\":'{\"EmailAddress\":\"\(email)\",\"Patient_DOB\":\"\(tfDateSymStarted.text ?? "")\",\"Patient_Gender\":\"\(gender)\",\"Patient_Ethnicity\":\"\(race)\"}'}"
            print("RegisterPortal verification: \(dic)")
            
            let authUrl = Endpoint.account
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getKpiDashboardData(url: authUrl, strData: dic, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.isSuccess ?? false {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterPortalTwo") as! RegisterPortalTwo
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

    
    func checkConnectivityGender() {
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.gender
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getRelationData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.count != 0 {
                        
                        self.ageList = dashboads
                        //self.ageTableView.reloadData()
                        self.checkConnectivityEthinicity()
                        
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
    
    func checkConnectivityEthinicity() {
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.ethinicity
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getRelationData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.count != 0 {
                        self.raceList = dashboads
                        //self.raceTableView.reloadData()
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
    @IBAction func buttonCalPressed(_ sender: Any) {
        //        let calendarPicker = JBCalendarViewController()
        //        calendarPicker.popoverPresentationController?.sourceView = btnDateSymBackGndView
        //        calendarPicker.delegate = self
        //        // Configure the calendar's properties
        //        present(calendarPicker, animated: true, completion: nil)
        //showDatePicker()
       // tfDateSymStarted.inputView = datePicker
        datePickerBackGndview.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func heighlighBoarderColorAge(boolVal: Bool){
       
 //    dropDownBackgroundView.sendSubviewToBack(self.navigationController!.view)
//        tfRelationShip.bringSubviewToFront(dropDownBackgroundView)
//        btnImageDropdown.bringSubviewToFront(dropDownBackgroundView)
//        btnDropdown.bringSubviewToFront(dropDownBackgroundView)
        
        backGndViewAge.isHidden = !boolVal
        
        if boolVal {
            tfAge.layer.borderColor = UIColor.Citygo.redColor.cgColor
            tfAgeDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            tfAge.layer.borderColor = UIColor.clear.cgColor
            tfAgeDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor

        }
        
        tfAge.layer.borderWidth = 0.4
        tfAge.layer.cornerRadius = 5.0
        
        tfAgeDummy.layer.borderWidth = 0.4
        tfAgeDummy.layer.cornerRadius = 5.0
    }

    func heighlighBoarderColorRace(boolVal: Bool){
       
 //    dropDownBackgroundView.sendSubviewToBack(self.navigationController!.view)
//        tfRelationShip.bringSubviewToFront(dropDownBackgroundView)
//        btnImageDropdown.bringSubviewToFront(dropDownBackgroundView)
//        btnDropdown.bringSubviewToFront(dropDownBackgroundView)
        
        backGndViewRace.isHidden = !boolVal
        
        if boolVal {
            tfRace.layer.borderColor = UIColor.Citygo.redColor.cgColor
            tfRaceDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            tfRace.layer.borderColor = UIColor.clear.cgColor
            tfRaceDummy.layer.borderColor = UIColor.Citygo.redColor.cgColor

        }
        
        tfRace.layer.borderWidth = 0.4
        tfRace.layer.cornerRadius = 5.0
        
        tfRaceDummy.layer.borderWidth = 0.4
        tfRaceDummy.layer.cornerRadius = 5.0
    }

}

extension RegisterPortalOne: JBCalendarViewControllerDelegate {
    func calendarViewControllerDateChanged(_ calendarViewController: JBCalendarViewController) {
        print(calendarViewController.date)
        tfDateSymStarted.text = calendarViewController.date.convertToDateFormat()
        btnNext.btnEnable(boolVal: true)
        calendarViewController.dismiss(animated: true, completion: nil)
    }
    
    func calendarViewControllerWillDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
    func calendarViewControllerDidDismiss(_ calendarViewController: JBCalendarViewController) {
        //
    }
    
  
}

extension RegisterPortalOne: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ageTableView {
            return ageList.count
        } else {
            return raceList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguagesCell", for: indexPath) as! LanguagesCell
        if tableView == ageTableView {
            cell.titleLbl.text = ageList[indexPath.row].Text
        } else {
            cell.titleLbl.text = raceList[indexPath.row].Text
        }

        cell.contentView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
        cell.titleLbl.textColor = UIColor.Citygo.formsubtitlesnotselected
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ageTableView {
            self.heighlighBoarderColorAge(boolVal: false)
            tfAge.text = ageList[indexPath.row].Text
            tfAgeDummy.text = ageList[indexPath.row].Text
            gender = ageList[indexPath.row].Value ?? ""
          //  backGndViewAge.isHidden = false
        } else {
            self.heighlighBoarderColorRace(boolVal: false)
            tfRace.text = raceList[indexPath.row].Text
            tfRaceDummy.text = raceList[indexPath.row].Text
           // backGndViewRace.isHidden = false
            race = raceList[indexPath.row].Value ?? ""
        }
    }
}
