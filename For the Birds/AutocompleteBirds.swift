//
//  AutocompleteBirds.swift
//  For the Birds
//
//  Created by SFurlani on 1/6/17.
//  Copyright © 2017 sfurlani. All rights reserved.
//

import UIKit
import AutoCompletion

class AutocompleteBirds: NSObject, AutoCompletionTextFieldDataSource {
    
    let names: [String]
    
    var suggestions: [String:[String]]
    let words: Set<String>
    
    init(names: [String]) {
        self.names = names
        
        let notAlphanumeric = CharacterSet.alphanumerics.inverted
        let wordsFromName = names.flatMap { $0.components(separatedBy: notAlphanumeric) }.map { $0.lowercased() }
        words = Set(wordsFromName)
        suggestions = [String:[String]]()
    }
    
    func fetchSuggestions(forIncompleteString: String!, withCompletionBlock completion: FetchCompletionBlock!) {
        let key = forIncompleteString!.lowercased()
        
        guard key.characters.count > 1 else {
            completion([], key)
            return
        }
        
        let guessWords = words.filter { $0.contains(key) }
        
        var guessedAlready = Set<String>()
        var search = [[String:String]]()
        
        for word in guessWords {
            if suggestions[word] == nil {
                suggestions[word] = names.filter{ $0.localizedCaseInsensitiveContains(word) }
            }
            for guess in suggestions[word]! {
                if !guessedAlready.contains(guess) {
                    guessedAlready.insert(guess)
                    search.append(["title":guess])
                }
            }
        }

        completion?(search, key)
    }

}
