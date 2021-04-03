//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Anika Nair on 3/22/21.
//

import UIKit

class QuestionViewController: UIViewController {

@IBOutlet var QuestionLabel: UILabel!
    
@IBOutlet var SingleStackView: UIStackView!
@IBOutlet var SingleButton1: UIButton!
@IBOutlet var SingleButton2: UIButton!
@IBOutlet var SingleButton3: UIButton!
@IBOutlet var SingleButton4: UIButton!
    
@IBOutlet var MultipleStackView: UIStackView!
@IBOutlet var MultiLabel1: UILabel!
@IBOutlet var MultiLabel2: UILabel!
@IBOutlet var MultiLabel3: UILabel!
@IBOutlet var MultiLabel4: UILabel!

@IBOutlet var MultiSwitch1: UISwitch!
@IBOutlet var MultiSwitch2: UISwitch!
@IBOutlet var MultiSwitch3: UISwitch!
@IBOutlet var MultiSwitch4: UISwitch!
    
    
@IBOutlet var RangedStackView: UIStackView!
@IBOutlet var RangedLabel1: UILabel!
@IBOutlet var RangedLabel2: UILabel!
@IBOutlet var RangedSlider: UISlider!
    
@IBOutlet var QuestionProgressView: UIProgressView!
    
    
    var questions: [Question] = [
        
        Question(text: "Which food do you like the most?",
                 type:.single,
        answers: [
            Answer(text: "Steak", type: .dog),
            Answer(text: "Fish", type: .cat),
            Answer(text: "Carrots", type: .rabbit),
            Answer(text: "Corn", type: .turtle)

            ]),
        
    Question(text: "Which activities do you enjoy ?",
             type:.multiple,
    answers: [
     Answer(text: "Swimming", type: .turtle),
        
     Answer(text: "Sleeping", type: .cat),
        
    Answer(text: "Cuddling", type: .rabbit),
    
    Answer(text: "Eating", type: .dog)

     ]),
        
    Question(text: "How much do you enjoy car rides?",
        type: .ranged,
answers: [
    
    Answer(text: "I dislike them", type: .cat),
            
   Answer(text: "I get a little nervous", type: .rabbit),
            
    Answer(text: "I barely notice them", type: .turtle),
            
  Answer(text: "I love them", type: .dog)
          
          ])
        
    ]
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    updateUI()
     
    }
    
 func updateUI() {

    SingleStackView.isHidden = true
    MultipleStackView.isHidden = true
    RangedStackView.isHidden = true

        navigationItem.title = "Question #\(questionIndex+1)"
    
    let currentQuestion = questions[questionIndex]
    
    let currentAnswers = currentQuestion.answers
    
    let totalProgress = Float(questionIndex) /
            Float(questions.count)
    
QuestionLabel.text =
    currentQuestion.text
        
QuestionProgressView.setProgress(totalProgress, animated:
            true)
    
switch currentQuestion.type {
        case .single:
            SingleStackView.isHidden = false
    updateSingleStack(using: currentAnswers)
            
        case .multiple:
            MultipleStackView.isHidden = false
        updateMultipleStack(using: currentAnswers)
            
        case .ranged:
            RangedStackView.isHidden = false
    updateRangedStack(using: currentAnswers)

        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        SingleStackView.isHidden = false
        
        SingleButton1.setTitle(answers[0].text, for: .normal)
        
        SingleButton2.setTitle(answers[1].text, for: .normal)
        
        SingleButton3.setTitle(answers[2].text, for: .normal)
        
        SingleButton4.setTitle(answers[3].text, for: .normal)
        }
    
func updateMultipleStack(using answers: [Answer]) {
        
    MultipleStackView.isHidden = false
    
    MultiSwitch1.isOn = false
    MultiSwitch2.isOn = false
    MultiSwitch3.isOn = false
    MultiSwitch4.isOn = false
    
     MultiLabel1.text = answers[0].text
        
      MultiLabel2.text = answers[1].text
        
      MultiLabel3.text = answers[2].text
        
      MultiLabel4.text = answers[3].text
    
    }
    
func updateRangedStack(using answers: [Answer]) {
    RangedStackView.isHidden = false
    
    RangedSlider.setValue(0.5, animated: false)
    
    RangedLabel1.text = answers.first?.text
        
    RangedLabel2.text = answers.last?.text
        
    }
   
    
    @IBAction func SingleAnswerButtonPressed(_ sender: UIButton) {
    
    let currentAnswers = questions[questionIndex].answers

    switch sender {
    
    case SingleButton1:
    answersChosen.append(currentAnswers[0])
    
    case SingleButton2:
     answersChosen.append(currentAnswers[1])
        
           
    case SingleButton3:
     answersChosen.append(currentAnswers[2])
        
        
  case SingleButton4:
   answersChosen.append(currentAnswers[3])
    
    default:
            break
        }
    
        nextQuestion()
    }
    
   
    @IBAction func MultipleAnswerButtonPressed(_ sender: UIButton) {
    
    let currentAnswers = questions[questionIndex].answers
    
if MultiSwitch1.isOn {
        answersChosen.append(currentAnswers[0])
        }
if MultiSwitch2.isOn {
        answersChosen.append(currentAnswers[1])
    }
if MultiSwitch3.isOn {
    answersChosen.append(currentAnswers[2])
    }
if MultiSwitch4.isOn {
    answersChosen.append(currentAnswers[3])
    }
    
    nextQuestion()

    }
    
@IBAction func RangedAnswerButtonPressed() {
    
    let currentAnswers = questions[questionIndex].answers
    
let index = Int(round(RangedSlider.value *
        Float(currentAnswers.count - 1)))
        
answersChosen.append(currentAnswers[index])
        
            nextQuestion()
    }

    func nextQuestion (){
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            
        }
            else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
                
        }
            }
        
    override func prepare(for segue: UIStoryboardSegue, sender:
      Any?) {
        if segue.identifier == "ResultsSegue" {
    
        let resultsViewController = segue.destination as! ResultsViewController
        resultsViewController.responses = answersChosen
            

                }
            }
           
        }
    
    


    
    
    

