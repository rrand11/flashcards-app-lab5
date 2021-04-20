//
//  FlashcardSet.swift
//  CS422L
//
//  Created by Jonathan Sligh on 2/3/21.
//


import Foundation

class FlashcardSetOld {
    var title: String = ""
    
    static func getHardCodedCollection() -> [FlashcardSet]
    {
        var sets = [FlashcardSet]()
        for i in 1...10
        {
            let set = FlashcardSet()
            set.title = "Title \(i)"
            sets.append(set)
        }
        return sets
    }
}
 
 
