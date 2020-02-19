//
//  NoteTableViewController.swift
//  MarkProject
//
//  Created by boehrer nicolas on 12/02/2020.
//  Copyright © 2020 Boehrer Nicolas. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var notes : [Note] = [
        Note(title: "Note1", content: "Ceci est la note 1 ", date: "12-02-2020"),
        Note(title: "Note2", content: "Ceci est la note 2 ", date: "12-02-2020"),
        Note(title: "Note3", content: "Ceci est la note 3 ", date: "12-02-2020"),
        Note(title: "Note4", content: "Ceci est la note 4 ", date: "12-02-2020"),
    ];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = "\(note.title)"
        cell.detailTextLabel?.text = "\(note.date)"


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        print("\(note.title) - \(indexPath)")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedNote = notes.remove(at: fromIndexPath.row)
        notes.insert(movedNote, at: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     
     @IBAction func unwindToNoteTableView(segue: UIStoryboardSegue) {
         //KarenUnwind == Save
         if segue.identifier == "SaveUnwind" {
             let sourceViewController = segue.source as! AddEditNoteTableViewController
             if let note = sourceViewController.note {
                 if let selectedIndexPath = tableView.indexPathForSelectedRow {
                     notes[selectedIndexPath.row] = note
                     tableView.reloadRows(at: [selectedIndexPath], with: .fade)
                 }else{//add note
                     let newIndexPath = IndexPath(row: notes.count, section: 0)
                     notes.append(note)
                     tableView.insertRows(at: [newIndexPath], with: .fade)
                 }
             }
         }
         
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNote" {
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
        
            let navigationController = segue.destination as! UINavigationController
            let addEditController = navigationController.topViewController as! AddEditNoteTableViewController
            addEditController.note = note
        }
    }
}
