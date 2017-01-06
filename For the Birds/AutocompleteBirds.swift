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
    
    init(filename: String) {
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = Bundle.main.path(forResource: filename, ofType: "json")
        
        let contentData = FileManager.default.contents(atPath: filePath!)
        
        let json = try? JSONSerialization.jsonObject(with: contentData!, options: .allowFragments)
        
        names = json as! [String]
    }
    
    func fetchSuggestions(forIncompleteString: String!, withCompletionBlock completion: FetchCompletionBlock!) {
        let key = forIncompleteString!
        
        guard key.characters.count > 2 else {
            completion([], key)
            return
        }
        
        let search = names.filter { $0.localizedCaseInsensitiveContains(key) }.sorted().map { ["title":$0] }

        completion?(search, key)
    }

}
