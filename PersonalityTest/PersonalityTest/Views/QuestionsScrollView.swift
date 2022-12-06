//
//  QuestionsScrollView.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import UIKit

protocol QuestionsScrollViewDelegate: AnyObject {
    func didScroll(forward: Bool)
    func didFinish()
}

class QuestionsScrollView: UIScrollView {
    weak var pageDelegate: QuestionsScrollViewDelegate?
    weak var answerDelegate: AnswerDelegate?
    
    let questions: [Question]
    var questionsViews = [UIView]()
    
    private(set) var currentPage: Int = 0
    lazy var questionsStackView = UIStackView(views: questionsViews, axis: .horizontal, distribution: .fillEqually)
    
    init(questions: [Question]) {
        self.questions = questions
        super.init(frame: .zero)
        
        for question in questions {
            let questionView = QuestionView(withQuestion: question)
            questionView.delegate = self
            questionsViews.append(questionView)
        }
        
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.removeGestureRecognizer(panGestureRecognizer)
        self.addSubview(questionsStackView)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        questionsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(questions.count)
        }
    }
    
    func scrollToPage(index: Int) {
        self.setContentOffset(CGPoint(x: self.bounds.width * CGFloat(index), y: self.contentOffset.y), animated: true)
        let scrollForward = currentPage < index
        currentPage = index
        pageDelegate?.didScroll(forward: scrollForward)
    }
    
    func isLastPageShown() -> Bool {
        return currentPage == questions.count - 1
    }
    
    func showPreviousPage() {
        if currentPage > 0 {
            scrollToPage(index: currentPage - 1)
        }
    }
    
    func showNextPage() {
        if !isLastPageShown() {
            scrollToPage(index: currentPage + 1)
        } else {
            pageDelegate?.didFinish()
        }
    }
    
    func resetToFirstPage() {
        currentPage = 0
        scrollToPage(index: currentPage)
        questionsViews.forEach { view in
            if let questionView = view as? QuestionView {
                questionView.resetQuestionView()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionsScrollView: AnswerDelegate {
    func choseAnswer(answer: Answer, questionId: UUID) {
        answerDelegate?.choseAnswer(answer: answer, questionId: questionId)
    }
}
