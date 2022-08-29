//
//  ViewController.swift
//  ChessTimer
//
//  Created by Ploo Jompong on 2022-08-29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerOneTimer: UILabel!
    @IBOutlet weak var playerTwoTimer: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var time1: Double = 300.0
    var time2: Double = 300.0
    
    var isTimerRunning: Bool = false
    var state: Bool = true

    var timer: Timer  = Timer()
    var timeFormatter = DateComponentsFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timeFormatter.allowedUnits = [.minute, .second]
        
        let timeRemainingOne = timeFormatter.string(from: TimeInterval(time1))
        let timeRemainingTwo = timeFormatter.string(from: TimeInterval(time2))
                
        playerOneTimer.text = timeRemainingOne
        playerTwoTimer.text = timeRemainingTwo

    }
    
    @IBAction func startTimer(_ sender: Any) {
        btnStart.setTitle("Switch", for: .normal)
        runTimer()
    }
    
    func runTimer() {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: countDown(timer:))
            isTimerRunning = true
        }
        
        if state {
            state = false
            
        } else {
            state = true
        }
    }
    
    func countDown(timer: Timer?) {
        if !state {
            if time1 > 0 {
                time1 -= 1
                playerOneTimer.text = timeFormatter.string(from: TimeInterval(time1))
            } else if time1 == 0 {
                timer?.invalidate()
            }
        } else {
            if time2 > 0 {
                time2 -= 1
                playerTwoTimer.text = timeFormatter.string(from: TimeInterval(time2))
            }
            else if time2 == 0 {
                timer?.invalidate()
            }
        }
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        btnStart.setTitle("Start", for: .normal )
        timer.invalidate()
        isTimerRunning = false
        state = true
        time1 = 300.0
        time2 = 300.0
        playerOneTimer.text = timeFormatter.string(from: TimeInterval(time1))
        playerTwoTimer.text = timeFormatter.string(from: TimeInterval(time2))
    }
}
