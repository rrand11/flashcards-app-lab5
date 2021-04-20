//
//  EditAlertViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/18/21.
//
import Foundation
import UIKit
import CoreData

class EditAlertViewController: UIViewController {

    @IBOutlet var alertView: UIView!
    @IBOutlet var termEditText: UITextField!
    @IBOutlet var definitionEditText: UITextField!
    
    //card from FlashCardSetDetailViewController
    var card: Flashcard?
    
    var row: IndexPath?
    
    //use this later to do things to the flashcards potentially
    var parentVC: FlashCardSetDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    
    func setup()
    {
        alertView.layer.cornerRadius = 8.0
        self.parentVC?.getCardsFromDB()
        //set term/def
        //make it so it shows this is editable
        termEditText.becomeFirstResponder()
    }
    
    @IBAction func deleteFlashcard(_ sender: Any) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // deletes from the database but not the tableview
        let managedContext =
        appDelegate.persistentContainer.viewContext
        managedContext.delete(card!)
        do {
            try managedContext.save()
            }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        //self.parentVC?.tableView.reloadData()
        
        //indexpath?.actual row clicked ??
        self.parentVC?.flashcard.remove(at: row?.row ?? 0) // ??0 = if doesn't exist, put a 0
        self.parentVC?.tableView.deleteRows(at: [row!], with: .fade) // ! forces it
        
        
        //elf.parentVC?.tableView.reloadData()
        
        self.parentVC?.tableView.reloadRows(at: [row!], with: .fade)
    }
    
    @IBAction func doneEditing(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            
            
            self.card?.term = self.termEditText.text
            self.card?.definition = self.definitionEditText.text
            
            self.parentVC?.flashcard[self.row?.row ?? 0] = self.card!
            self.parentVC?.tableView.reloadData()
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            // deletes from the database but not the tableview
            let managedContext =
            appDelegate.persistentContainer.viewContext
            do {
                try managedContext.save()
                }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        })
    }
}
