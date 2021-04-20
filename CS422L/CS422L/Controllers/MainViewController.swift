//
//  ViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 1/29/21.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet var collectionView: UICollectionView!
        var sets: [FlashcardSet] = []
        var setsStatic: [String] = ["Set 1","Set 2", "Set 3", "Set 5", "Set 6", "Set 42", "Set Things", "Set Stuff"]
        var currentIndex = 0
        var setSelected: FlashcardSet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSetsFromDB()
        collectionView.delegate = self
        collectionView.dataSource = self
        makeThingsLookPretty()
    }
    
    func getSetsFromDB() // gets flashcardset entity from database
        {
            guard let appDelegate =
               UIApplication.shared.delegate as? AppDelegate else {
                 return
             }
             
             let managedContext =
               appDelegate.persistentContainer.viewContext
            
                //pass in entity name to get from the database
             let fetchRequest =
               NSFetchRequest<NSManagedObject>(entityName: "FlashcardSet")
             
             // fetches the fetch requests and casts it to the array of sets
            // makes flaaashcardset intertwined with the database - any updates to it will update it in the the db automatically
             do {
                sets = try managedContext.fetch(fetchRequest) as? [FlashcardSet] ?? []
             } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
             }
        }

    
        @IBAction func addNewSet(_ sender: Any) {
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext =
            appDelegate.persistentContainer.viewContext

            let entity =
            NSEntityDescription.entity(forEntityName: "FlashcardSet",
                                      in: managedContext)!

            let set = NSManagedObject(entity: entity,
                                      insertInto: managedContext) as! FlashcardSet
            set.title = setsStatic[currentIndex]
            currentIndex += 1
            if (currentIndex >= setsStatic.count)
            {
                currentIndex = 0
            }
            
            do {
                try managedContext.save()
                sets.append(set)
                collectionView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCell", for: indexPath) as! FlashcardSetCollectionCell
        //setup method just makes it look nice
        cell.setup()
        cell.textLabel.text = sets[indexPath.row].title
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //go to new view
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
    //another function to make things look nice
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    //just a function to make things look nice
    func makeThingsLookPretty()
    {
        let margin: CGFloat = 10
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}

