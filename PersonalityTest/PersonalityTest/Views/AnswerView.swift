//
//  AnswerView.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 5.12.22.
//

import UIKit

class AnswerView: UIControl {
    
    lazy var answerNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var answerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = .black
        return label
    }()
    
    lazy var contentStackView = UIStackView(views: [answerNumberLabel, answerTitleLabel], axis: .horizontal, spacing: 10)
    
    lazy var contentInsetStackView = UIStackView(views: [contentStackView], axis: .horizontal, layoutInsets: .init(top: 10, left: 10, bottom: 10, right: 10))
    
    let answer: Answer
    let answerNumber: Int
    
    init(withAnswer answer: Answer, answerNumber: Int) {
        self.answer = answer
        self.answerNumber = answerNumber
        super.init(frame: .zero)
        
        addSubview(contentInsetStackView)
        
        answerNumberLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        contentInsetStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureSubviews()
    }
    
    func configureSubviews() {
        contentInsetStackView.layer.borderWidth = 2
        contentInsetStackView.layer.borderColor = UIColor.lightGray.cgColor
        contentInsetStackView.layer.cornerRadius = 12
        
        answerTitleLabel.text = answer.answerTitle
        answerNumberLabel.text = "\(answerNumber)"
    }
    
    func configureSelectedAnswer(isSelected: Bool) {
        if isSelected {
            contentInsetStackView.layer.borderColor = UIColor.red.cgColor
            contentInsetStackView.backgroundColor = .red.withAlphaComponent(0.3)
        } else {
            contentInsetStackView.layer.borderColor = UIColor.gray.cgColor
            contentInsetStackView.backgroundColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
