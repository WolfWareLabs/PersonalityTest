//
//  QuestionView.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import UIKit

protocol AnswerDelegate: AnyObject {
    func choseAnswer(answer: Answer, questionId: UUID)
}

class QuestionView: UIView {

    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var answersStackView = UIStackView(views: [], axis: .vertical, spacing: 10)
    
    lazy var contentStackView = UIStackView(views: [questionTitleLabel, answersStackView, UIView()], axis: .vertical, spacing: 20)
    
    var question: Question
    var lastSelectedAnswer = 0
    
    weak var delegate: AnswerDelegate?
    
    init(withQuestion question: Question) {
        self.question = question
        super.init(frame: .zero)

        addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureSubviews()
    }
    
    func configureSubviews() {
        if let answers = self.question.answersArray {
            var answerNumber = 1
            for answer in answers {
                let answerView = AnswerView(withAnswer: answer, answerNumber: answerNumber)
                
                let answerTapGestureRecognizer = AnswerTapGestureRecognizer(target: self, action: #selector(answerTap(tapGestureRecognizer:)))
                answerTapGestureRecognizer.answer = answer
                answerTapGestureRecognizer.answerNumber = answerNumber - 1
                answerView.isUserInteractionEnabled = true
                answerView.addGestureRecognizer(answerTapGestureRecognizer)
                
                answersStackView.addArrangedSubview(answerView)
                answerNumber += 1
            }
        }
        
        questionTitleLabel.text = question.questionTitle
    }
    
    func resetQuestionView() {
        answersStackView.subviews.forEach { view in
            if let answerView = view as? AnswerView {
                answerView.configureSelectedAnswer(isSelected: false)
            }
        }
    }
    
    @objc func answerTap(tapGestureRecognizer: AnswerTapGestureRecognizer) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction) {
            if let answerView = self.answersStackView.subviews[self.lastSelectedAnswer] as? AnswerView {
                answerView.configureSelectedAnswer(isSelected: false)
            }
            
            if let answerView = self.answersStackView.subviews[tapGestureRecognizer.answerNumber] as? AnswerView {
                answerView.configureSelectedAnswer(isSelected: true)
                self.lastSelectedAnswer = tapGestureRecognizer.answerNumber
            }
        }
        delegate?.choseAnswer(answer: tapGestureRecognizer.answer, questionId: question.questionId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class AnswerTapGestureRecognizer: UITapGestureRecognizer {
    var answer = Answer()
    var answerNumber = Int()
}
