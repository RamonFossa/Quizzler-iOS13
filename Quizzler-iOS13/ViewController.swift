//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var selectedButton: Bool!
    var answeredQuestions: Int = 0
    var rightAnswers: Int = 0
    var standardBackgroundColor: UIColor!
    var canClick = false
    
    var myArray: [Int] = []
    var rightAnswer: Bool = false
    
    let quiz: [[String: Any]] = [
        [
            "question": "2+3 = 5?",
            "answer": true
        ],
        [
            "question": "5x0 = 0?",
            "answer": true
        ],
        [
            "question": "20-10 = 9?",
            "answer": false
        ],
        [
            "question": "5-10x3 = -15?",
            "answer": false
        ],
        [
            "question": "200/0 = 0?",
            "answer": false
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for number in 0..<quiz.count {
            self.myArray.append(number)
        }
        self.myArray = self.myArray.shuffled()
        updateQuestion()
        updateProgressBar()
        self.standardBackgroundColor = trueButton.backgroundColor
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if !self.canClick { return }
        self.canClick = false
        guard let answerPressed = sender.currentTitle else { return }
        let answerPressedBoolean = answerPressed == "True"
        self.selectedButton = answerPressedBoolean
        self.answeredQuestions += 1
        self.handleAnswer(isRightAnswer: answerPressedBoolean == rightAnswer)
    }
    
    func handleAnswer(isRightAnswer: Bool) {
        if isRightAnswer { self.rightAnswers += 1}
        self.answerFeedback(isRightAnswer: isRightAnswer)
        self.prepareNextQuestion()
    }
    
    func answerFeedback(isRightAnswer: Bool) {
        self.updateProgressBar()
        self.changeButtonColor(isRightAnswer: isRightAnswer)
    }
    
    func prepareNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
                self.changeButtonColor(isRightAnswer: nil)
            if self.answeredQuestions == self.quiz.count {
                self.endGame()
                return
            }
            self.updateQuestion()
        }
    }
    
    func updateProgressBar() {
        self.progressBar.progress = Float(self.answeredQuestions) / Float(self.quiz.count)
    }
    
    func updateQuestion() {
        guard let question = quiz[self.myArray[self.answeredQuestions]]["question"] as? String, let answer = quiz[self.myArray[self.answeredQuestions]]["answer"] as? Bool else { return }
        self.questionLabel.text = question
        self.rightAnswer = answer
        self.canClick = true
    }
    
    func endGame() {
        let isRed = rightAnswers <= (self.quiz.count / 2)
        self.questionLabel.text = "Acabouuuuu, você acertou \(self.rightAnswers) de \(self.quiz.count) perguntas"
        self.questionLabel.textColor = UIColor(red: isRed ? 0.6 : 0, green: isRed ? 0 : 0.6, blue: 0, alpha: 1.0)
        self.trueButton.isHidden = true
        self.falseButton.isHidden = true
    }
    
    func changeButtonColor(isRightAnswer: Bool?) {
        guard let isRightAnswer = isRightAnswer else {
            self.trueButton.backgroundColor  = self.standardBackgroundColor
            self.falseButton.backgroundColor = self.standardBackgroundColor
            return
        }

        if self.selectedButton {
            self.trueButton.backgroundColor  = UIColor(red: (isRightAnswer ? 0.0 : 0.6), green: (!isRightAnswer ? 0.0 : 0.6), blue: 0.0, alpha: 1.0)
            return
        }
        self.falseButton.backgroundColor = UIColor(red: (isRightAnswer ? 0.0 : 0.6), green: (!isRightAnswer ? 0.0 : 0.6), blue: 0.0, alpha: 1.0)
    }
}

