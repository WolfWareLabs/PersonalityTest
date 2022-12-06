//
//  LandingViewController.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 2.12.22.
//

import SnapKit
import UIKit

class LandingViewController: BaseViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.landingTitleLabel
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.landingDescriptionLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var startButton: StandardButton = {
        let button = StandardButton(title: Strings.buttonStart, type: .fill)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.setButtonEnabled(isEnabled: false)
        return button
    }()
    
    lazy var contentStackView = UIStackView(views: [titleLabel, descriptionLabel, UIView(), startButton], axis: .vertical, spacing: 16)
    
    let viewModel = QuestionsViewModel()
    var questionsReady = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
        }
        
        viewModel.getQuestions { isSucessfull in
            //we can implement some error handling here if needed
            DispatchQueue.main.async {
                self.startButton.setButtonEnabled(isEnabled: true)
            }
            self.questionsReady = true
        }
    }
    
    @objc func startButtonTapped() {
        if questionsReady {
            show(QuestionsViewController(withViewModel: viewModel), sender: self)
        }
    }
    
}
