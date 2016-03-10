//
//  SettingsViewController.swift
//  GitHub
//
//  Created by Xiaofei Long on 3/10/16.
//  Copyright © 2016 dreloong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var searchSettings: RepoSearchSettings!

    @IBOutlet weak var minStarsField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        minStarsField.text = "\(searchSettings.minStars)"
        minStarsField.keyboardType = .NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions

    @IBAction func onCancel(sender: AnyObject) {
        minStarsField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSave(sender: AnyObject) {
        if minStarsField.text != "" {
            searchSettings.minStars = Int(minStarsField.text!)!
        }
        minStarsField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
