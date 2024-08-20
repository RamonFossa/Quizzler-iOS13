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
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.quizBrain.initQuiz()
    }
    
    func setupUI() {
        self.quizBrain.questionLabel = self.questionLabel
        self.quizBrain.trueButton = self.trueButton
        self.quizBrain.falseButton = self.falseButton
        self.quizBrain.progressBar = self.progressBar
        self.quizBrain.scoreLabel = self.scoreLabel
        
        self.quizBrain.standardBackgroundColor = trueButton.backgroundColor
        self.updateScoreLabel(self.quizBrain.getScore())
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        self.quizBrain.answerButtonPressed(sender) { score in
            self.updateScoreLabel(score)
        }
    }
    
    func updateScoreLabel(_ score: (rightAnswers: Int, totalQuestions: Int)) {
        self.scoreLabel.text = "Score: \(score.rightAnswers)/\(score.totalQuestions)"
    }
    
}

