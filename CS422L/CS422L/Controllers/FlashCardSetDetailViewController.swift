//
//  FlashCardSetDetailActivity.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/3/21.
//

import Foundation
import UIKit
import CoreData

class FlashCardSetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    //var selectedSet: FlashcardSet?
    var flashcard: [Flashcard] = []
   
    @IBOutlet var buttonView: UIView!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var studyButton: UIButton!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCardsFromDB()
        tableView.delegate = self
        tableView.dataSource = self
        makeItPretty()
    }
    
    
    func getCardsFromDB() // gets flashcardset entity from database
        {
            guard let appDelegate =
               UIApplication.shared.delegate as? AppDelegate else {
                 return
             }
             
             let managedContext =
               appDelegate.persistentContainer.viewContext
            
                //pass in entity name to get from the database
             let fetchRequest =
               NSFetchRequest<NSManagedObject>(entityName: "Flashcard")
             
             // fetches the fetch requests and casts it to the array of sets
            // makes flashcard intertwined with the database - any updates to it will update it in the the db automatically
             do {
                flashcard = try managedContext.fetch(fetchRequest) as? [Flashcard] ?? []
             } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
             }
        }
    
    @IBAction func goBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    
    @IBAction func addCard(_ sender: Any) {
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext =
            appDelegate.persistentContainer.viewContext

            let entity =
            NSEntityDescription.entity(forEntityName: "Flashcard",
                                      in: managedContext)!

            let card = NSManagedObject(entity: entity,insertInto: managedContext) as! Flashcard
                //card.flashcardset = selectedSet
                card.term = "New Term"
                card.definition = "New Definition"
            
            do {
                try managedContext.save()
                flashcard.append(card)
                tableView.reloadData()
                }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! FlashcardTableViewCell
        cell.flashcardLabel.text = flashcard[indexPath.row].term
        cell.selectionStyle = .none
        return cell
    }
        
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "\(String(describing: flashcard[indexPath.row].term))", message: "\(String(describing: flashcard[indexPath.row].definition))", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            
            // passing index path from alert into create custom alert function to use
            self.createCustomAlert(card: self.flashcard[indexPath.row],path: indexPath)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func createCustomAlert(card: Flashcard, path: IndexPath)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let alertVC = sb.instantiateViewController(identifier: "EditAlertViewController") as! EditAlertViewController
        alertVC.parentVC = self
        alertVC.card = card
        alertVC.modalPresentationStyle = .overCurrentContext
        
        // using index path that was passed from alert dialog so it can be used in custom alert
        alertVC.row = path
        
        //tableView.reloadData()
        
        self.present(alertVC, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete {
                //tableView.reloadData()
                let deletedCard = flashcard[indexPath.row]
                
                
                guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let managedContext =
                appDelegate.persistentContainer.viewContext
                managedContext.delete(deletedCard)
                
                //Flashcard?.removeFromAlbums(deletedCard)
                flashcard.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
    
    //just a function to make everything look nice
    func makeItPretty()
    {
        buttonView.layer.cornerRadius = 8.0
        buttonView.layer.borderColor = UIColor.purple.cgColor
        buttonView.layer.borderWidth = 2.0
        deleteButton.layer.cornerRadius = 8.0
        studyButton.layer.cornerRadius = 8.0
        addButton.layer.cornerRadius = 8.0
    }
}
