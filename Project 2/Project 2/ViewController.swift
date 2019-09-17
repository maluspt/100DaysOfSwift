//
//  ViewController.swift
//  Project 2
//
//  Created by Maria Luiza Carvalho Sperotto on 17/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var Score: UILabel!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 0
    
    let maxQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        askQuestion()
        

}
    func askQuestion(action: UIAlertAction! = nil) {
        currentQuestion += 1
        
        if currentQuestion > maxQuestions {
            showResult()
            return
        }
        
        
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
       
        
}
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "CORRECT!"
            message = ""
            score += 1
            Score.text = "Score: \(score)"
        } else {
            title = "WRONG!"
            message = "This flag is from \(countries[sender.tag].uppercased())"
            
            score -= 1
            Score.text = "Score: \(score)"
            
            
            
        }
         // alert pop-up
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(ac, animated: true)
    }
    
    func showResult() {
        
        //alert
        
        let alert = UIAlertController(title: "Game Over!", message: "Your score was \(score) out of \(maxQuestions)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: askQuestion))
        
        
         // "restarts" the game
        score = 0
        currentQuestion = 0
        correctAnswer = 0
        Score.text = "Score: \(score)"
        
        
    
        
        present(alert, animated: true)
    }
    
    
    }

    
    
    
    
    
    
    
    

