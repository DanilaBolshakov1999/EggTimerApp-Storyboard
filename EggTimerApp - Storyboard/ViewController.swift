//
//  ViewController.swift
//  EggTimerApp - Storyboard
//
//  Created by Danila Bolshakov on 20.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let timer = Timer()
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    private let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    private var totalTime = 0
    private var secondsPassed = 0
    private var player: AVAudioPlayer!
    private let sound = "alarm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        progressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE"
            
            let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
