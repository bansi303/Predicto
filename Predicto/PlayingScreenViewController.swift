//
//  PlayingScreenViewController.swift
//  Predicto
//
//  Created by Student on 2020-02-20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol playingDelegate {
    func changeSoundBtnStatus(status:String)
}

class PlayingScreenViewController: UIViewController {
    
    @IBOutlet weak var lblResultStatstics: UILabel!
    @IBOutlet weak var lblRandomNumber: UILabel!
    @IBOutlet weak var lblScore: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var sliderPredictNumber: RangeSeekSlider!
    @IBOutlet weak var btnTry: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var viewHint: UIView!
    
    var generatedRandomNumber = 0
    var selectedGameType:GameType!
    var hintUsageCount = 0
    var delegate:playingDelegate!
    
    enum GameType {
        case Easy
        case Medium
        case Hard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblScore.setTitle("10", for: UIControl.State.normal)
        // Do any additional setup after loading the view.
        if selectedGameType == .Easy{
            sliderPredictNumber.minValue = 1
            sliderPredictNumber.maxValue = 10
        }
        else if selectedGameType == .Medium{
            sliderPredictNumber.minValue = 1
            sliderPredictNumber.maxValue = 50
        }
        else{
            sliderPredictNumber.minValue = 1
            sliderPredictNumber.maxValue = 100
        }
        
        if !Utility.sharedInstace.isSoundEnable{
            btnSound.setBackgroundImage(UIImage.init(named: "sound_off"), for: UIControl.State.normal)
        }
        else{
            btnSound.setBackgroundImage(UIImage.init(named: "sound_on"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func onBackBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTryBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        lblResultStatstics.isHidden = true
        btnCheck.isEnabled = true
        let randomNumber = arc4random_uniform(UInt32(sliderPredictNumber!.maxValue)) + 1
        generatedRandomNumber = Int(randomNumber)
        lblRandomNumber.text = "\(randomNumber)"
        
        if Int(lblScore.titleLabel?.text ?? "0")! >= 5{
            viewHint.alpha = 1
            viewHint.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func onCheckBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        btnCheck.isEnabled = false
        viewHint.alpha = 0.5
        viewHint.isUserInteractionEnabled = false
        Utility.sharedInstace.playBtnTapSound()
        lblResultStatstics.isHidden = false
        
        var userWin = false
        if generatedRandomNumber == Int(sliderPredictNumber.selectedMaxValue){
            let newScore = Int(lblScore.titleLabel?.text ?? "0")! + 10
            lblScore.setTitle("\(newScore)", for: UIControl.State.normal)
            userWin = true
            lblResultStatstics.text = "Congratulation!! You won 10 coins"
            lblResultStatstics.textColor = UIColor.init(red: 0, green: 100/255.0, blue: 0, alpha: 1)
        }
        
        if !userWin{
            if selectedGameType == .Medium || selectedGameType == .Hard{
                if generatedRandomNumber > (Int(sliderPredictNumber.selectedMaxValue) - 3) && generatedRandomNumber < (Int(sliderPredictNumber.selectedMaxValue) + 3){
                    let newScore = Int(lblScore.titleLabel?.text ?? "0")! + 5
                    lblScore.setTitle("\(newScore)", for: UIControl.State.normal)
                    lblResultStatstics.text = "Just missed!! You won 5 coins"
                    lblResultStatstics.textColor = .orange
                }
                else{
                    lblResultStatstics.text = "Better luck next time."
                    lblResultStatstics.textColor = .red
                }
            }
            else{
                lblResultStatstics.text = "Better luck next time."
                lblResultStatstics.textColor = .red
            }
        }
    }
    
    @IBAction func onResetBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        resetPlay()
    }
    
    @IBAction func onHintBtnClicked(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        hintUsageCount = hintUsageCount + 1
        
        sliderPredictNumber.selectedMaxValue = CGFloat(generatedRandomNumber)
        sliderPredictNumber.layoutSubviews()
        
        let newScore = Int(lblScore.titleLabel?.text ?? "0")! - 5
        lblScore.setTitle("\(newScore )", for: UIControl.State.normal)
        
        if hintUsageCount == 10 || newScore == 0{
            viewHint.alpha = 0.5
            viewHint.isUserInteractionEnabled = false
        }
        Utility.sharedInstace.playBtnTapSound()
        
    }
    
    @IBAction func onSoundBtnTapped(_ sender: UIButton) {
        Utility.sharedInstace.playBtnTapSound()
        if Utility.sharedInstace.isSoundEnable{
            btnSound.setBackgroundImage(UIImage.init(named: "sound_off"), for: UIControl.State.normal)
            delegate.changeSoundBtnStatus(status: "off")
        }
        else{
            btnSound.setBackgroundImage(UIImage.init(named: "sound_on"), for: UIControl.State.normal)
            delegate.changeSoundBtnStatus(status: "on")
        }
        
        Utility.sharedInstace.isSoundEnable = !Utility.sharedInstace.isSoundEnable
    }
    
    func resetPlay(){
        hintUsageCount = 0
        sliderPredictNumber.selectedMaxValue = CGFloat(1)
        sliderPredictNumber.layoutSubviews()
        lblRandomNumber.text = "00"
        btnCheck.isEnabled = false
        lblResultStatstics.isHidden = true
        lblScore.setTitle("0", for: UIControl.State.normal)
        viewHint.alpha = 0.5
        viewHint.isUserInteractionEnabled = false
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
