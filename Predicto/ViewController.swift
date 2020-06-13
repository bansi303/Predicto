//
//  ViewController.swift
//  Predicto
//
//  Created by Student on 2020-02-20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnSound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func onEasyBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        self.performSegue(withIdentifier: "play", sender: "easy")
    }
    
    @IBAction func onMediumBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        self.performSegue(withIdentifier: "play", sender: "medium")
    }
    
    @IBAction func onHardBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        self.performSegue(withIdentifier: "play", sender: "hard")
    }
    
    @IBAction func onSoundfBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        if Utility.sharedInstace.isSoundEnable{
            sender.setBackgroundImage(UIImage.init(named: "sound_off"), for: UIControl.State.normal)
        }
        else{
            sender.setBackgroundImage(UIImage.init(named: "sound_on"), for: UIControl.State.normal)
        }
        
        Utility.sharedInstace.isSoundEnable = !Utility.sharedInstace.isSoundEnable
    }
    
    @IBAction func onInfoBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier?.elementsEqual("play"))!{
            let vc = segue.destination as! PlayingScreenViewController
            vc.delegate = self
            if (sender as! String).elementsEqual("easy"){
                vc.selectedGameType = .Easy
            }
            else if (sender as! String).elementsEqual("medium"){
                vc.selectedGameType = .Medium
            }
            else if (sender as! String).elementsEqual("hard"){
                vc.selectedGameType = .Hard
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

extension ViewController:playingDelegate{
    func changeSoundBtnStatus(status: String) {
        if status.elementsEqual("off"){
            btnSound.setBackgroundImage(UIImage.init(named: "sound_off"), for: UIControl.State.normal)
        }
        else{
            btnSound.setBackgroundImage(UIImage.init(named: "sound_on"), for: UIControl.State.normal)
        }
    }
}

