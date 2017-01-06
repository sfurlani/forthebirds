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
    
    init(names: [String]) {
        self.names = names
        suggestions = [String:[String]]()
    }
    
    func fetchSuggestions(forIncompleteString: String!, withCompletionBlock completion: FetchCompletionBlock!) {
        let key = forIncompleteString!
        
        guard key.characters.count > 1 else {
            completion([], key)
            return
        }
        
        if suggestions[key] == nil {
            let search = names.filter{ $0.localizedStandardContains(forIncompleteString) }
            suggestions[forIncompleteString] = search
        }
        
        let search = suggestions[key]!.map { ["title": $0] }
        
        completion?(search, key)
    }

}
