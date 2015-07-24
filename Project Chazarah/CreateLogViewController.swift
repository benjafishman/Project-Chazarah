//
//  CreateLogViewController.swift
//  Project Chazarah
//
//  Created by Ben Fishman on 7/23/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import UIKit

class CreateLogViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logTextInput: UITextView!
    @IBOutlet weak var numberInput: UITextField!
    
    var passedBook : Book?
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dateLabel.text = passedBook?.getTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
