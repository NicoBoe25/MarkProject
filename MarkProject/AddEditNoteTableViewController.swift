//
//  AddEditNoteTableViewController.swift
//  MarkProject
//
//  Created by boehrer nicolas on 12/02/2020.
//  Copyright © 2020 Boehrer Nicolas. All rights reserved.
//

import UIKit

class AddEditNoteTableViewController: UITableViewController {

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = note {
            titleTextField.text = note.title
            contentTextField.text = note.content
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
    
    @IBAction func textViewChanged(_ sender: UITextView) {
        updateSaveButtonState()
    }
    
    // Button to set current user location on the map
    
    @IBAction func setUserLocationOnMap(_ sender: Any) {
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
                        
            note = Note(title: title, content: content, date: now, local: "")
        }
     
    }
    

}
