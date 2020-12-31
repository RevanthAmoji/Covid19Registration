//
//  ScheduleScreentwoAllDates.swift
//  covid
//
//  Created by venkata baisani on 10/12/20.
//

import UIKit

class ScheduleScreentwoAllDates: UIViewController {
    
    @IBOutlet weak var itemsTableView:UITableView!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    var slots:slots = SingletonData.shared.getSlotsDetails()
    
    lazy var availableSlots:[Datas]? = []
    
    var previousSelTableVal:Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.itemsTableView.reloadData()
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
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


// MARK: UITableView Delegate and Datasource Methods
extension ScheduleScreentwoAllDates : UITableViewDataSource, UITableViewDelegate
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slots.AvailableDates?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTwoAvailableCell", for: indexPath) as! ScheduleTwoAvailableCell
       
        let model = slots.AvailableDates?[indexPath.row]
        cell.titlelbl.text = model?.Text
        cell.subTitlelbl.text =  "\(model?.Value ?? "0") slots available"
        
        if previousSelTableVal == indexPath.row {
            
            cell.backGndView.backgroundColor = UIColor.Citygo.navigationBar
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.white
            cell.subTitlelbl.textColor = UIColor.white
        
        } else {
            
            cell.backGndView.backgroundColor = UIColor.white
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            cell.titlelbl.textColor = UIColor.Citygo.navigationBar
            cell.subTitlelbl.textColor = UIColor.Citygo.navigationBar
    
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        previousSelTableVal = indexPath.row
        itemsTableView.reloadData()
    }
    
}
