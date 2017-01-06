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
        
        
        let dataSource = AutocompleteBirds(filename: "birds")
        
        autocompletionTextField.suggestionsResultDataSource = dataSource
        
        autocompletionTextField.suggestionsResultDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        autocompletionTextField.becomeFirstResponder()
    }

    
    func textField(_ textField: AutoCompletionTextField!, didSelectItem selectedItem: Any!) {
        guard let item = selectedItem as? [String: String] else { return }
        textField.text = item["title"]
    }


}
