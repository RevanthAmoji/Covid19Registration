//
//  ConfirmScreeningVC.swift
//  covid
//
//  Created by venkata baisani on 21/12/20.
//

import UIKit
import MapKit

class ConfirmScreeningVC: UIViewController {

    
    @IBOutlet weak var lblClientName:UILabel!
    @IBOutlet weak var lblClientAddress:UILabel!
    @IBOutlet weak var lblTestDate:UILabel!
    @IBOutlet weak var lblTestTime:UILabel!
    
    @IBOutlet weak var lblTitle:UILabel!
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBOutlet weak var directionBtn: SutherlandButton!
    
    var availableSlots:MyScheduleTests?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        directionBtn.btnEnable(boolVal: true)
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        // Do any additional setup after loading the view.
        setPreviousData()
        
        let btnArr = self.view.subviews(ofType: UIImageView.self)
        
        for item in btnArr {
            let itemVal = item as UIImageView
            itemVal.backgroundColor = UIColor.Citygo.h1headingone
        }
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonUI.shared.naviagationBarRightButton(vc: self, barItem: profileBarButton)
    }
    func setPreviousData() {
        
        lblTitle.text = "\(availableSlots?.PatientName ?? "") (\(availableSlots?.PatientRelationship ?? ""))"
        
        lblClientName.text = availableSlots?.ClinicName
        lblClientAddress.text = availableSlots?.ClinicAddress
        lblTestDate.text = availableSlots?.TestDate
        lblTestTime.text = availableSlots?.TestTime
        
    }
    
    @IBAction func btnGetDirectionsAction(_ sender: Any) {
        self.getDirections()
    }
    func getDirections() {
        /*
        //34.0288° N, 118.4718° W
       //let directionsURL = "http://maps.apple.com/?saddr=34.03845,-118.47514&daddr=\(availableSlots?.Latidude ?? ""),\(availableSlots?.Logitude ?? "")"
        var directionsURL = "http://maps.apple.com/?daddr=\(availableSlots?.ClinicAddress ?? "")"
        directionsURL = directionsURL.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        */
        let coordinate = CLLocationCoordinate2DMake(Double(availableSlots?.Latidude ?? "0") ?? 0,Double(availableSlots?.Logitude ?? "0") ?? 0)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = availableSlots?.ClinicAddress ?? "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
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
