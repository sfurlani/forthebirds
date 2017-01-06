//
//  ViewController.swift
//  For the Birds
//
//  Created by SFurlani on 1/6/17.
//  Copyright © 2017 sfurlani. All rights reserved.
//

import UIKit
import AutoCompletion

class ViewController: UIViewController, AutoCompletionTextFieldDelegate {

    @IBOutlet weak var autocompletionTextField: AutoCompletionTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = Bundle.main.path(forResource: "birds", ofType: "json")
        
        let contentData = FileManager.default.contents(atPath: filePath!)
        
        let json = try? JSONSerialization.jsonObject(with: contentData!, options: .allowFragments)
        
        let names = json as! [String]
        
        let dataSource = AutocompleteBirds(names: names)
        
        autocompletionTextField.suggestionsResultDataSource = dataSource
        
        autocompletionTextField.suggestionsResultDelegate = self
        
    }

    
    func textField(_ textField: AutoCompletionTextField!, didSelectItem selectedItem: Any!) {
        print(selectedItem)
        guard let item = selectedItem as? [String: String] else { return }
        textField.text = item["title"]
    }


}
