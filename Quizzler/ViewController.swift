//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions : QuestionBank = QuestionBank()
    var pickedAnswer : Bool = false
    var questionIndex : Int = 0
    var score : Double = 0
    var countRight : Int = 0
    var countWrong : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstQuestion = allQuestions.list[questionIndex]
        questionLabel.text = firstQuestion.question
        startOver()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        print(questionIndex)
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else {
            pickedAnswer = false
        }
        checkAnswer()
        nextQuestion()
    }
    
    func formatScore() -> Double {
        return Double(round(100 * score)/100)
    }
    
    
    func updateUI() {
        let questionCount = allQuestions.list.count
        progressLabel.text = "\(questionIndex) / \(questionCount)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(questionCount)) * CGFloat(questionIndex)
        scoreLabel.text = "\(formatScore())"
    }

    func nextQuestion() {
        questionIndex = questionIndex + 1
        updateUI()
        if questionIndex < allQuestions.list.count {
            questionLabel.text = allQuestions.list[questionIndex].question
        }
        else {
            let alertController = UIAlertController(title: "Awesome!", message: "You just finished all \(allQuestions.list.count) questions, You got \(countRight) right! with score \(formatScore()) / 100", preferredStyle: .alert )
            let alertAction = UIAlertAction(title: "Restart", style: .destructive) { (UIAlertAction) in
                self.startOver()
            }
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func checkAnswer() {
        if (pickedAnswer == allQuestions.list[questionIndex].answer) {
            score = score + (100.0 * (1.0 / Double(allQuestions.list.count)))
            countRight = countRight + 1
            ProgressHUD.showSuccess("You answer \(pickedAnswer), you got it!")
        }
        else {
            countWrong = countWrong + 1
            ProgressHUD.showError("You answer \(pickedAnswer), not right!")
        }
    }
    
    func startOver() {
        print("Start Over ================================")
        questionIndex = 0
        score = 0
        countWrong = 0
        countRight = 0
        updateUI()
    }

}
