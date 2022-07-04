//
//  ProfileViewController.swift
//  SpudBase
//
//  Created by Gabrielle Walsh on 7/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var tapCount: Int = 0
    
    @IBOutlet weak var counterTextField: UITextField!

    @IBOutlet weak var tapMeButton: UIButton!
    @IBAction func onTap(_ sender: Any) {
        tapCount += 1
        counterTextField.text = String(tapCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterTextField.text = String(tapCount)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
