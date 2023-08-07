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
    
    let quiz: [Question] = [
        Question("2+3 = 5?", true),
        Question("5x0 = 0?", true),
        Question("20-10 = 9?", false),
        Question("5-10x3 = -15?", false),
        Question("200/0 = 0?", false),
        Question("A slug's blood is green.", true),
        Question("Approximately one quarter of human bones are in the feet.",  true),
        Question("The total surface area of two human lungs is approximately 70 square metres.",  true),
        Question( "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.",  true),
        Question("In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.",  false),
        Question("It is illegal to pee in the Ocean in Portugal.",  true),
        Question( "You can lead a cow down stairs but not up stairs.",  false),
        Question( "Google was originally called 'Backrub'.",  true),
        Question( "Buzz Aldrin's mother's maiden name was 'Moon'.",  true),
        Question( "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.",  false),
        Question( "No piece of square dry paper can be folded in half more than 7 times.",  false),
        Question( "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.",  false)
        
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
        self.questionLabel.text = self.getQuestion().text
        self.rightAnswer = self.getQuestion().answer
        self.canClick = true
    }
    
    func getQuestion() -> Question {
        return quiz[self.myArray[self.answeredQuestions]]
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

