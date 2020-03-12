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

class AddEditNoteTableViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    var contentTextView: String = ""
    
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
        
        textView.delegate = self
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        
                
        if let imageToLoad = note?.photo {
            imageView.image  = UIImage(named: imageToLoad)
        }
        
        if let note = note {
            titleTextField.text = note.title
            textView.text = note.content
            currentUserLocation = note.local
            updateMapCurrentUserLocation(location: currentUserLocation!);
        }
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateSaveButtonState(){
        let title = titleTextField.text ?? ""
        let content = textView.text ?? ""
        
        saveButton.isEnabled = !title.isEmpty && !content.isEmpty
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ sender: UITextView) {
        updateSaveButtonState()
        contentTextView = textView.text
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        currentUserLocation = mUserLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(mRegion, animated: true)

        // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = "Current Location"
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
    
    func updateMapCurrentUserLocation(location: CLLocation) {
        // zoom
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        mapView.setRegion(mRegion, animated: true)
        // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        mkAnnotation.title = "Note's Location"
        mapView.addAnnotation(mkAnnotation)
    }
    
    func determineUserPhoto(){
        print("Clic sur bouton Photo")
    }
    
    
    // Button to set current user location on the map
    @IBAction func setUserLocationOnMap(_ sender: Any) {
        determineCurrentLocation()
    }
    
    // Button to set current photo on the view
    @objc func setUserPhoto(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        pickerController.allowsEditing = false
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = originalImage
        }else {
            print("Erreur Image t'es nul")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //a Modifier erreur local

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveUnwind" {
            let title = titleTextField.text ?? ""
            let content = contentTextView
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = df.string(from: Date())
            
            let local = currentUserLocation
            
            note = Note(title: title, content: content, date: now, local: local ?? CLLocation(latitude: 47.6, longitude: 6.8), photo: "")
        }
     
    }
    

}
