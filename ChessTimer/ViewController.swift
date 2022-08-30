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
    
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var time1: TimeInterval = 300.0
    var time2: TimeInterval = 300.0
    
    var isTimerRunning: Bool = false
    var state: Bool = true

    var timer: Timer  = Timer()
    var timeFormatter = DateComponentsFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Set labels to default
        resetTimer(nil)

    }
    
    @IBAction func startTimer(_ sender: UIButton!) {
        btnStart.setTitle("Switch", for: .normal)
        runTimer()
    }
    
    func runTimer() {
        // Check if timer is running
        if !isTimerRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: countDown(timer:))
            isTimerRunning = true
        }
        
        /*
         Always start with Player 1 timer
         Check whose turn it is
        */
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
                playerOneTimer.text = timeFormatter.string(from: time1)
            } else if time1 == 0 {
                timer?.invalidate()
                playerOne.textColor = UIColor.red
                playerTwo.textColor = UIColor.green
                playerTwo.font = UIFont.boldSystemFont(ofSize: 20)
            }
        } else {
            if time2 > 0 {
                time2 -= 1
                playerTwoTimer.text = timeFormatter.string(from: time2)
            }
            else if time2 == 0 {
                timer?.invalidate()
                playerOne.textColor = UIColor.green
                playerOne.font = UIFont.boldSystemFont(ofSize: 20)
                playerTwo.textColor = UIColor.red
            }
        }
    }
    
    // Reset to default
    @IBAction func resetTimer(_ sender: UIButton!) {
        btnStart.setTitle("Start", for: .normal )
        timer.invalidate()
        timeFormatter.allowedUnits = [.minute, .second]
        isTimerRunning = false
        state = true
        time1 = 300.0
        time2 = 300.0
        playerOneTimer.text = timeFormatter.string(from: time1)
        playerTwoTimer.text = timeFormatter.string(from: time2)
        playerOne.textColor = UIColor.black
        playerTwo.textColor = UIColor.black
        playerOne.font = UIFont.systemFont(ofSize: 17)
        playerTwo.font = UIFont.systemFont(ofSize: 17)
    }
}
