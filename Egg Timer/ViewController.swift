//
//  ViewController.swift
//  Egg Timer
//
//  Created by Neobis on 20/6/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!

    var totalTime = 0
    
    var target = 0 {
        didSet {
            let min = String(format: "%02d", minutes)
            let sec = String(format: "%02d", seconds)
            timeLabel.text = "\(min):\(sec)"
            progressBar.setProgress(.zero, animated: true)
        }
    }
    
    var seconds: Int {
        target % 60
    }
    
    var minutes: Int {
        target / 60
    }
    
    var timer: Timer?

    // MARK: - Actions
    
    @IBAction func eggButtonTouched(_ sender: UIButton) {
        let text: String
        switch sender {
        case softButton:
            text = "You choised soft mode"
            target = 5 * 60
        case mediumButton:
            text = "You choised medium mode"
            target = 10 * 60
        case hardButton:
            text = "You choised hard mode"
            target = 15 * 60
        default:
            text = "Sabit chort"
        }
        totalTime = target

        timer?.invalidate()
        timer = nil
        resultLabel.text = text
    }
    
    @IBAction func startTouched(_ sender: UIButton) {
        guard timer == nil else {return}
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.target -= 1
            let diff = self.totalTime - self.target
            let division: Float = Float(diff) / Float(self.totalTime)
            self.progressBar.setProgress(division, animated: true)
            self.resultLabel.text = "Cooking is in progress"
            if self.target == .zero {
                timer.invalidate()
                self.resultLabel.text = "Your eggs are ready"
                return
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

