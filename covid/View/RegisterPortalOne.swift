//
//  RegisterPortalOne.swift
//  covid
//
//  Created by venkata baisani on 11/12/20.
//

import UIKit
import JBCalendarDatePicker

class RegisterPortalOne: UIViewController {
    
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
    
    var ageList:[String] = ["Male","Femal","Other"]
    var raceList:[String] = ["A","B","C","Other"]
    
    @IBOutlet weak var ageTableView: UITableView!
    @IBOutlet weak var raceTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.btnEnable(boolVal: false)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dropdownBtnAgeAction(_ sender: Any) {
    
        self.heighlighBoarderColorAge(boolVal: true)
        ageTableView.reloadData()
    }
    
    @IBAction func dropdownBtnRaceAction(_ sender: Any) {
    
        self.heighlighBoarderColorRace(boolVal: true)
        raceTableView.reloadData()
    }
    

    @IBAction func buttonCalPressed(_ sender: Any) {
        let calendarPicker = JBCalendarViewController()
        calendarPicker.popoverPresentationController?.sourceView = btnDateSymBackGndView
        calendarPicker.delegate = self
        // Configure the calendar's properties
        present(calendarPicker, animated: true, completion: nil)
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
         cell.titleLbl.text = ageList[indexPath.row]
        } else {
            cell.titleLbl.text = raceList[indexPath.row]
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
            tfAge.text = ageList[indexPath.row]
            tfAgeDummy.text = ageList[indexPath.row]
          //  backGndViewAge.isHidden = false
        } else {
            self.heighlighBoarderColorRace(boolVal: false)
            tfRace.text = raceList[indexPath.row]
            tfRaceDummy.text = raceList[indexPath.row]
           // backGndViewRace.isHidden = false
        }
    }
}
