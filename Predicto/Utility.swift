//
//  Utility.swift
//  Predicto
//
//  Created by Student on 2020-02-21.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import AVKit

class Utility: NSObject {

    var audioPlayer = AVAudioPlayer()
    static var sharedInstace = Utility()
    var isSoundEnable = true
    
    override init() {
        let btnTapSound = URL(fileURLWithPath: Bundle.main.path(forResource: "btnTapSound", ofType: "mp3")!)
        do{
            audioPlayer = try AVAudioPlayer.init(contentsOf: btnTapSound)
        }
        catch{
            
        }
        audioPlayer.prepareToPlay()
    }
    
    func playBtnTapSound(){
        if isSoundEnable{
            audioPlayer.play()            
        }
    }
}
