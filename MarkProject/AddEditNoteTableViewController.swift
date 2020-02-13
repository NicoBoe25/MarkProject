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
    
    @IBOutlet weak var userLocatoinButton: UIButton!
    
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
    

    // MARK: - Table view data source
    /*
     //pas touche
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
