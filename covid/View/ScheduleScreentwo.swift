//
//  ScheduleScreentwo.swift
//  covid
//
//  Created by venkata baisani on 08/12/20.
//

import UIKit

extension Date {

    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}

class ScheduleScreentwo: UIViewController {
    
    @IBOutlet weak var itemsCollectionView:UICollectionView!
    
    @IBOutlet weak var itemsTableView:UITableView!
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    var slots:slots?
    
    lazy var availableSlots:[Datas]? = []
    
    var previousSelVal:Int = -1
    var previousSelTableVal:Int = -1
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.itemsCollectionView.register(UINib(nibName: "ScheduleTwoDaysCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleTwoDaysCell")
       
        itemsCollectionView.reloadData()
        itemsCollectionView.layoutIfNeeded()
        
        btnNext.btnEnable(boolVal: false)
        self.checkConnectivityRelation()
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func checkConnectivityRelation() {
        
        if Reachability.isConnectedToNetwork() {
    
            let authUrl = Endpoint.slotslist+(SingletonData.shared.hospitalID ?? "")+Endpoint.requiredDate+getCurrentDate()
            print("location url: \(authUrl as Any)")
            Services.getDashboardService().getSlotsData(url: authUrl, completion: {
                result in
                switch result {
                
                case .success(let dashboads):
                    self.slots = dashboads
                    self.itemsCollectionView.reloadData()
                    self.itemsCollectionView.layoutIfNeeded()
                   
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScheduleScreentwo: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    // MARK:------------------------------
    // MARK: Collection View Data Source Methods
    // MARK:------------------------------
    
    /// Here we deside the sections.
    /// - Not require multiple sections that's why maintains section count is 1.
    ///
    /// - Parameter collectionView: It is used to costomise the layout in any way we wish like horizental and vertical.
    /// - Returns: Here returns the Integer value.
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1     //return number of sections in collection view
    }
    
    /// Here we deside number of items in each section based dynamic array count.
    ///
    /// - Parameter collectionView: It is used to costomise the layout in any way we wish like horizental and vertical.
    /// - Returns: Here returns the Integer value.

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return slots?.AvailableDates?.count ?? 0
    }
    
    /// Here Display dynamic 'Reports' data from array by using index value in each item.
    ///
    /// - Parameter collectionView: It is used to costomise the layout in any way we wish like horizental and vertical.
    /// - Returns: Here returns item view.
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleTwoDaysCell", for: indexPath as IndexPath) as! ScheduleTwoDaysCell
        
        let model = slots?.AvailableDates?[indexPath.row]
        cell.titlelbl.text = model?.Text
        cell.subTitlelbl.text =  model?.Value
        
        if previousSelVal == indexPath.row {
            
            cell.backGndView.backgroundColor = UIColor.Citygo.navigationBar
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.white
            cell.subTitlelbl.textColor = UIColor.white
            
        } else {
            
            cell.backGndView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
            cell.backGndView.layer.borderColor = UIColor.Citygo.textFieldBackGroundColor.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.Citygo.navigationBar
            cell.subTitlelbl.textColor = UIColor.Citygo.navigationBar
        }
        
        return cell      //return your cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width/3 - 15
        return CGSize(width: Double(width), height: Double(85))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = slots?.AvailableDates?[indexPath.row]
        availableSlots = slots?.Data?.filter {$0.AppointmentDateStr == model?.Text}
        
        previousSelVal = indexPath.row
        itemsCollectionView.reloadData()
        let modelVal = slots?.AvailableDates?[indexPath.row]
        SingletonData.shared.testDate = modelVal?.Text
        itemsTableView.reloadData()
    }
}

// MARK: UITableView Delegate and Datasource Methods
extension ScheduleScreentwo : UITableViewDataSource, UITableViewDelegate
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableSlots?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTwoAvailableCell", for: indexPath) as! ScheduleTwoAvailableCell
        let model = availableSlots?[indexPath.row]
       // cell.setModelData(awareness: model)
        let slot = "\(model?.SlotStart ?? "") - \(model?.SlotEnd ?? "")"
        cell.titlelbl.text = slot
        cell.subTitlelbl.text = "Available"
        
        if previousSelTableVal == indexPath.row {
            
            cell.backGndView.backgroundColor = UIColor.Citygo.navigationBar
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.white
            cell.subTitlelbl.textColor = UIColor.white
            
            cell.tickImage.isHidden = false
            cell.widthConstant.constant = 30
            
        } else {
            
            cell.backGndView.backgroundColor = UIColor.white
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.Citygo.navigationBar
            cell.subTitlelbl.textColor = UIColor.Citygo.navigationBar
            
            cell.tickImage.isHidden = true
            cell.widthConstant.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        previousSelTableVal = indexPath.row
        itemsTableView.reloadData()
        let model = availableSlots?[indexPath.row]
        let slot = "\(model?.SlotStart ?? "") - \(model?.SlotEnd ?? "")"
        SingletonData.shared.testTime = slot
        SingletonData.shared.slotId = model?.SlotID
        btnNext.btnEnable(boolVal: true)
    }
    
}
