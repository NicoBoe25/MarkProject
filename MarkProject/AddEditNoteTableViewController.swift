//
//  AddEditNoteTableViewController.swift
//  MarkProject
//
//  Created by boehrer nicolas on 12/02/2020.
//  Copyright © 2020 Boehrer Nicolas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddEditNoteTableViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var currentLocationStr = "Current location"
    var locationManager:CLLocationManager!
    
    var currentUserLocation: CLLocation?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    var selectedImage: String?
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        if let imageToLoad = note?.photo {
            imageView.image  = UIImage(named: imageToLoad)
        }
        
        if let note = note {
            titleTextField.text = note.title
            contentTextField.text = note.content
            currentUserLocation = note.local
        }
        updateSaveButtonState()
    }

    
    func updateSaveButtonState(){
        let title = titleTextField.text ?? ""
        let content = contentTextField.text ?? ""
        
        saveButton.isEnabled = !title.isEmpty && !content.isEmpty
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            // 2: success! Set its selectedImage property
//            vc.selectedImage = pictures[indexPath.row]
//
//            // 3: now push it onto the navigation controller
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        currentUserLocation = mUserLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mRegion, animated: true)

        // Get user's Current Location and Drop a pin
    let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mapView.addAnnotation(mkAnnotation)
    }
    
    //MARK:- Intance Methods
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    
    
    //MARK:- Intance Methods

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func determineUserPhoto(){
        print("Clic sur bouton Photo")
    }
    
    
    // Button to set current user location on the map
    @IBAction func setUserLocationOnMap(_ sender: Any) {
        determineCurrentLocation()
    }
    
    // Button to set current user location on the map
    @IBAction func setUserPhoto(_ sender: Any) {
        determineUserPhoto()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveUnwind" {
            let title = titleTextField.text ?? ""
            let content = contentTextField.text ?? ""
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = df.string(from: Date())
            
            let local = currentUserLocation
                        
            note = Note(title: title, content: content, date: now, local: local!)
            note = Note(title: title, content: content, date: now, local: "", photo: "")
        }
     
    }
    

}
