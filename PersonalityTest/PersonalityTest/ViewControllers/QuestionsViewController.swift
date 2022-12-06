//
//  QuestionsViewController.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 2.12.22.
//

import UIKit

class QuestionsViewController: BaseViewController {
    
    lazy var questionsScrollView: QuestionsScrollView = {
        let scroll = QuestionsScrollView(questions: viewModel.questions)
        scroll.pageDelegate = self
        scroll.answerDelegate = self
        return scroll
    }()
    
    lazy var previousQuestionButton: StandardButton = {
        let button = StandardButton(title: Strings.buttonPrevious, type: .empty)
        button.addTarget(self, action: #selector(previousQuestionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var nextQuestionButton: StandardButton = {
        let button = StandardButton(title: Strings.buttonNextQuestion, type: .fill)
        button.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var buttonStackView = UIStackView(views: [previousQuestionButton, nextQuestionButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
    
    lazy var contentStackView = UIStackView(views: [questionsScrollView, UIView(), buttonStackView], axis: .vertical, spacing: 24, layoutInsets: UIEdgeInsets(top: 0, left: 12, bottom: 24, right: 12))
    
    var viewModel: QuestionsViewModel
    
    init(withViewModel viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentStackView)
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        setupNewTest()
    }
    
    func setupNewTest() {
        questionsScrollView.resetToFirstPage()
        viewModel.resetSelectedAnswers()
        didScroll(forward: true)
    }
    
    @objc func previousQuestionButtonTapped() {
        questionsScrollView.showPreviousPage()
    }
    
    @objc func nextQuestionButtonTapped() {
        questionsScrollView.showNextPage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionsViewController: QuestionsScrollViewDelegate {
    func didScroll(forward: Bool) {
        previousQuestionButton.setVisibility(value: questionsScrollView.currentPage > 0, animated: true)
        nextQuestionButton.setupButtonForLastPage(isLastPage: questionsScrollView.isLastPageShown())
        nextQuestionButton.setButtonEnabled(isEnabled: viewModel.selectedAnswers.count > questionsScrollView.currentPage)
     }
    
    func didFinish() {
        let viewController = ResultsViewController(withViewModel: viewModel)
        viewController.delegate = self
        show(viewController, sender: self)
    }
}

extension QuestionsViewController: AnswerDelegate {
    func choseAnswer(answer: Answer, questionId: UUID) {
        nextQuestionButton.setButtonEnabled(isEnabled: true)
        viewModel.addSelectedAnswer(selectedAnswer: answer, forQuestionId: questionId)
    }
}

extension QuestionsViewController: RetakeTestDelegate {
    func retakeTest() {
        setupNewTest()
    }
}
