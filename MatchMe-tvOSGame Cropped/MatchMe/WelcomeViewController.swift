//
//  WelcomeViewController.swift
//  MatchMe
//
//  Created on 10/19/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var enterNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var bestScoreButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Task: Create focus guide
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredFocusedView: UIView? {
        return self.nameTextField
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(self.nameTextField.text, forKey: kCurrentUserNameKey)
        defaults.synchronize()
    }
    
    //MARK: Focus
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        // TODO: Task: Implement focus guide changes
    }
    
    @IBAction func checkBestScoreButtonPressed(_: AnyObject) {
        print("best score tapped!")
    }
    
    
    
}

