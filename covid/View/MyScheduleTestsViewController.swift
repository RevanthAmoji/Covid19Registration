//
//  MyScheduleTestsViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class MyScheduleTestsViewController: UIViewController , ProgressBarShower {

    
    @IBOutlet weak var itemsTableView:UITableView!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
        
    var availableSlots:[MyScheduleTests]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        checkConnectivity()
        
        SingletonData.shared.isFromLogin = true
        
        clearAllpreviousData()
        
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }

    @IBAction func profileBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func profileViewBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func checkConnectivity() {
        
        self.showProgressBar()
        if Reachability.isConnectedToNetwork() {
    
           // let authUrl = Endpoint.accountDetails+"s.shetty@gmail.com"
            let authUrl = Endpoint.accountDetails+(SingletonData.shared.email ?? "")
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getMyScheduleData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    self.hideProgressBar()
                    if dashboads.count != 0 {
                        self.availableSlots = dashboads
                        self.itemsTableView.reloadData()
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
}


// MARK: UITableView Delegate and Datasource Methods
extension MyScheduleTestsViewController : UITableViewDataSource, UITableViewDelegate
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableSlots?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyScheduleTestsCell", for: indexPath) as! MyScheduleTestsCell
        let model = availableSlots?[indexPath.row]
       // cell.setModelData(awareness: model)
       // let slot = "\(model?.SlotStart ?? "") - \(model?.SlotEnd ?? "")"
        cell.titlelbl.text = model?.PatientName
//        cell.subTitlelbl.text = "Available"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let model = availableSlots?[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ConfirmScreeningVC") as! ConfirmScreeningVC
        controller.availableSlots = model
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    
    func clearAllpreviousData()
    {
        SingletonData.shared.firstNamePatient = ""
        SingletonData.shared.lastNamePatient = ""
        SingletonData.shared.email = ""
            SingletonData.shared.patientAge = ""
        SingletonData.shared.relationNumber = ""
        SingletonData.shared.relationName = ""
        SingletonData.shared.guardianFullName = ""
        SingletonData.shared.consent = ""
        SingletonData.shared.symptoms = ""
        SingletonData.shared.dateSymptomsStarted = ""
        SingletonData.shared.proritizedForTesting = ""
        SingletonData.shared.firstTimeTesting = ""
        SingletonData.shared.contactWithAnyOne = ""
        SingletonData.shared.medicalCondition = ""
        SingletonData.shared.pregnant = ""
        SingletonData.shared.highRiskCategory = ""
        SingletonData.shared.smoker = ""
        
        SingletonData.shared.primaryCareProvider = ""
        SingletonData.shared.careProvider = ""
        SingletonData.shared.addressLineOne = ""
        SingletonData.shared.addressLineTwo = ""
        SingletonData.shared.city = ""
        SingletonData.shared.state = ""
        SingletonData.shared.zipCode = ""
        SingletonData.shared.phoneNumber = ""
       // SingletonData.shared.email = data?.PrimaryCareEmail
        SingletonData.shared.careFacility = ""
        
        SingletonData.shared.dateOfBirth = ""
        SingletonData.shared.gender = ""
        SingletonData.shared.genderVal = ""
        SingletonData.shared.race = ""
        SingletonData.shared.raceVal = ""
        
        SingletonData.shared.addressLineOnePatient = ""
        SingletonData.shared.addressLineTwoPatient = ""
        SingletonData.shared.cityPatient = ""
        SingletonData.shared.statePatient = ""
        SingletonData.shared.zipCodePatient = ""
        SingletonData.shared.insuranceProvider = ""
        SingletonData.shared.policyNumber = ""
        SingletonData.shared.policyHolderName = ""
        SingletonData.shared.identification = ""
        SingletonData.shared.identificationVal = ""
    }
    
}
