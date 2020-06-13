//
//  HelpViewController.swift
//  Predicto
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        self.dismiss(animated: false) {
            
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
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
