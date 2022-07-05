//
//  ProfileViewController.swift
//  SpudBase
//
//  Created by Daniel Kwolek on 7/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func seeGithub(_ sender: Any) {
        if let url = URL(string: "https://www.github.com/danielmkwolek") {
            UIApplication.shared.open(url)
        }
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
