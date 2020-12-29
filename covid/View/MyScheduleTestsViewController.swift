//
//  MyScheduleTestsViewController.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit

class MyScheduleTestsViewController: UIViewController {

    
    @IBOutlet weak var itemsTableView:UITableView!
        
    var availableSlots:[MyScheduleTests]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        checkConnectivity()
        
        SingletonData.shared.isFromLogin = true
    }
    

    @IBAction func profileBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
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
        
        if Reachability.isConnectedToNetwork() {
    
           // let authUrl = Endpoint.accountDetails+"s.shetty@gmail.com"
            let authUrl = Endpoint.accountDetails+(SingletonData.shared.email ?? "")
            print("email verification: \(authUrl as Any)")
            Services.getDashboardService().getMyScheduleData(url: authUrl, completion: {
                result in
                switch result {
                case .success(let dashboads):
                    if dashboads.count != 0 {
                        self.availableSlots = dashboads
                        self.itemsTableView.reloadData()
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
    
}
