//
//  ViewController.swift
//  Project8
//
//  Created by Maria Luiza Carvalho Sperotto on 01/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var level = 1
    var score = 0 {
        didSet {
            scoreLabel.text = "Score \(score)"
        }
    }
    
    
    
    
    override func loadView() {

        
        
        // SCORES LABEL
        view = UIView()
        view.backgroundColor = .white
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "SCORE: 0"
        view.addSubview(scoreLabel)
        
        // CLUES LABEL
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)

        view.addSubview(cluesLabel)
        
        // ANSWERS LABEL
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
    
        // CURRENT ANSWER
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        // BUTTONS
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsView)
        
        

    
        
        
        
        //Constraints
        
        NSLayoutConstraint.activate([
            //puts the scoreLabel into the top right corner
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            // pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            //pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 200),
            // make the clue label 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            //make the answers label stick to the trailing edge of our layout margins, -100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -50),
            //make the answers take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            //male the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            //text field constraints
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            //buttons constraits
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            
            //give the button view a width and height
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            
            //center it horizontally
            
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            // set the top anchor to be the bottom of the submit buttom, +20
            
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            
            //pin it to the bottom of layour margins, -20
            
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
        ])
        
        //set some value for the width and height of each button
        
        let width = 150
        let height = 80
        
        //create 20 buttons as 4x5 grid
        
        for row in 0..<4 {
            for col in 0..<5 {
                //create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                //give the button some temporary text so we can see it on screen
                
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.setTitle("WWW", for: .normal)

                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                // calcuate the frame of this button using its col and row
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                
                // add it to the buttons view
                
                buttonsView.addSubview(letterButton)
                
                //and also to our letterButtons array
                
                letterButtons.append(letterButton)
            }
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadLevel()
        }
        
    }
    
    
    @objc func letterTapped(_ sender: UIButton) {
        //appends the button to the players answer, append button to the activateButtons and hide it
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        
        
        UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
            sender.alpha = 0
        })
        
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            
            
            if isAllButtonsPressed() {
                let alert = UIAlertController(title: "Well done", message: "Are you ready for the next level?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(alert, animated: true)
            }
        } else {
            score -= 1
            let alert = UIAlertController(title: "Wrong!", message: "\(answerText) does not match one of the answers!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }

        
    }
    
    
    func isAllButtonsPressed() -> Bool {
        for button in letterButtons {
            if button.isHidden == false {
                return false
            }
        }
        return true
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for button in activatedButtons {
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                button.alpha = 1
            })
        }
        
        activatedButtons.removeAll()
        
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadLevel()
        }
        
        for button in letterButtons {
            button.alpha = 1
        }
    }
    
    
    @objc func loadLevel() {
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
            
        }
        
        
        
        
        letterButtons.shuffle()
        
        DispatchQueue.main.async { [weak self] in
            self?.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
            if let letterButtons = self?.letterButtons {
            if letterButtons.count == letterBits.count {
                for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
     }
  }
}
}


