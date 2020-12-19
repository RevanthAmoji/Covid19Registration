//
//  ScheduleScreenOne.swift
//  covid
//
//  Created by venkata baisani on 30/11/20.
//

import UIKit
import MapKit

struct Stadium: Codable {
  var HospitalName: String?
  var HospitalID: String?
  var AvailableSlots: String?
  var ThreatmentType: String?
  var HospitalAddress: String?
  var Logitude: String?
  var Latidude: String?
}

class ScheduleScreenOne: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var itemsCollectionView:UICollectionView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var btnNext:SutherlandButton!
    
    var previousSelVal:Int = -1

    var stadiums:[Stadium] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkLocationServices()
        fetchStadiumsOnMap(stadiums)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        SingletonUI.shared.viewObjectsBackGndColor(viewController: self)
        
        self.itemsCollectionView.register(UINib(nibName: "MapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MapCollectionViewCell")
        
        btnNext.btnEnable(boolVal: false)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
      
        stadiums = (SingletonData.shared.getChartTypeDetails() as? [Stadium])!
        itemsCollectionView.reloadData()
        fetchStadiumsOnMap(stadiums)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
      }
    }
    
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        mapView.showsUserLocation = true
    
      // For these case, you need to show a pop-up telling users what's up and how to turn on permisneeded if needed
      case .denied:
        break
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
      case .restricted:
        break
      case .authorizedAlways:
        break
      @unknown default:
        break
      }
    }
    
    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
      for stadium in stadiums {
        let annotations = MKPointAnnotation()
        annotations.title = stadium.HospitalName
        annotations.coordinate = CLLocationCoordinate2D(latitude: Double(stadium.Logitude ?? "0.0") ?? 0, longitude: Double(stadium.Latidude ?? "0.0") ?? 0)
        let coordinateRegion = MKCoordinateRegion(center: annotations.coordinate, latitudinalMeters: 10, longitudinalMeters: 10)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotations)
      }
    }
    
    func setPinUsingMKPointAnnotation(location: CLLocationCoordinate2D,locationString:String) {
       let annotation = MKPointAnnotation()
       annotation.coordinate = location
       annotation.title = "Here"
       annotation.subtitle = "Device Location"
       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
       mapView.setRegion(coordinateRegion, animated: true)
       mapView.addAnnotation(annotation)
        
    }
    
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
        
        return stadiums.count
    }
    
    /// Here Display dynamic 'Reports' data from array by using index value in each item.
    ///
    /// - Parameter collectionView: It is used to costomise the layout in any way we wish like horizental and vertical.
    /// - Returns: Here returns item view.
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath as IndexPath) as! MapCollectionViewCell
        
        let model = stadiums[indexPath.row]
        cell.titlelbl.text = model.HospitalName
        cell.subTitlelbl.text = model.HospitalAddress
        cell.seats.text = (model.AvailableSlots ?? "0") + " Slots Available"
       
        if previousSelVal == indexPath.row {
            
            cell.backGndView.backgroundColor = UIColor.Citygo.textFieldBackGroundColor
            cell.backGndView.layer.borderColor = UIColor.Citygo.navigationBar.cgColor
            cell.backGndView.layer.borderWidth = 1.0
            
        } else {
            
            cell.backGndView.backgroundColor = UIColor.white
            cell.backGndView.layer.borderColor = UIColor.clear.cgColor
            cell.backGndView.layer.borderWidth = 1.0
        }
        
        return cell      //return your cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Double(218), height: Double(120))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        previousSelVal = indexPath.row
        let model = stadiums[indexPath.row]
        SingletonData.shared.clientName = model.HospitalName
        SingletonData.shared.clientAddress  = model.HospitalAddress
        itemsCollectionView.reloadData()
        btnNext.btnEnable(boolVal: true)
    }

}
//
////MARK: — MKMapView Delegate Methods
//extension ScheduleScreenOne: MKMapViewDelegate {
//   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
////      let annotationView  = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
////
////      annotationView.canShowCallout = true
////      if annotation is MKUserLocation {
////         return nil
////      } else {
////         annotationView.image =  UIImage(imageLiteralResourceName: "Pin")
////         return annotationView
////      }
//   }
//}
extension ScheduleScreenOne: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /// Thid is used to validate number plate and model when resign keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
      
       
    }
    /// Thid is used to validate number plate and model when typing on keypad
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
    }
}
