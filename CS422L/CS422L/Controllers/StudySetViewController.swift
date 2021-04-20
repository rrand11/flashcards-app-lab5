//
//  StudySetViewController.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/18/21.
//
/*
import UIKit

class StudySetViewController: UIViewController {

    @IBOutlet var cardView: UIView!
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var termLabel: UILabel!
    @IBOutlet var missedButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var correctButton: UIButton!
    @IBOutlet var missedLabel: UILabel!
    @IBOutlet var correctLabel: UILabel!
    var flashcards: [Flashcard] = []
    var currentIndex = 0
    var missedCount = 0
    var correctCount = 0
    var completedCount = 0
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup()
    {
        flashcards = Flashcard.getHardCodedCollection()
        totalCount = flashcards.count
        reloadViews()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showDefinition(_:)))
        cardView.addGestureRecognizer(gesture)
        makeItPretty()
    }
    
    @IBAction func showDefinition(_ sender:UITapGestureRecognizer)
    {
        //reset everything if at the end
        if flashcards.count == 0
        {
            flashcards = Flashcard.getHardCodedCollection()
            currentIndex = 0
            missedCount = 0
            correctCount = 0
            completedCount = 0
            totalCount = flashcards.count
            reloadViews()
            return
        }
        termLabel.text = flashcards[currentIndex].definition
    }
    
    @IBAction func missedClick(_ sender: Any) {
        missedCount += 1
        flashcards[currentIndex].missed = true
        currentIndex += 1
        if currentIndex > flashcards.count - 1
        {
            currentIndex = 0
        }
        reloadViews()
    }
    
    @IBAction func skipClick(_ sender: Any) {
        currentIndex += 1
        if currentIndex > flashcards.count - 1
        {
            currentIndex = 0
        }
        reloadViews()
    }
    
    @IBAction func correctClick(_ sender: Any) {
        if flashcards.count == 0
        {
            termLabel.text = "Click here to reset!"
            return
        }
        if !flashcards[currentIndex].missed
        {
            correctCount += 1
        }
        completedCount += 1
        flashcards.remove(at: currentIndex)
        if currentIndex > flashcards.count - 1
        {
            currentIndex = 0
        }
        reloadViews()
    }
    
    func reloadViews()
    {
        completedLabel.text = "Completed: \(completedCount) / \(totalCount)"
        missedLabel.text = "Missed: \(missedCount)"
        correctLabel.text = "Correct: \(correctCount)"
        if flashcards.count == 0
        {
            termLabel.text = "Click here to reset!"
            return
        }
        termLabel.text = flashcards[currentIndex].term
    }
    
    
    
    func makeItPretty()
    {
        cardView.layer.cornerRadius = 20.0
        cardView.layer.borderWidth = 3.0
        cardView.layer.borderColor = UIColor.systemPurple.cgColor
        missedButton.layer.cornerRadius = 8.0
        missedButton.layer.borderWidth = 1.0
        missedButton.layer.borderColor = UIColor.systemRed.cgColor
        skipButton.layer.cornerRadius = 8.0
        skipButton.layer.borderWidth = 1.0
        skipButton.layer.borderColor = UIColor.systemPurple.cgColor
        correctButton.layer.cornerRadius = 8.0
        correctButton.layer.borderWidth = 1.0
        correctButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
}
 */
