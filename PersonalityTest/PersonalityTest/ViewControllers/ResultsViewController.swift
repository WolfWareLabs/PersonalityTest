//
//  ResultsViewController.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 2.12.22.
//

import UIKit

protocol RetakeTestDelegate: AnyObject {
    func retakeTest()
}

class ResultsViewController: BaseViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.resultsTitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var resultsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var retakeTestButton: StandardButton = {
        let button = StandardButton(title: Strings.buttonRetakeTest, type: .fill)
        button.addTarget(self, action: #selector(retakeTestButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var contentStackView = UIStackView(views: [titleLabel, resultsDescriptionLabel, resultsLabel, UIView(), retakeTestButton], axis: .vertical, spacing: 16)
    
    var viewModel: QuestionsViewModel
    weak var delegate: RetakeTestDelegate?
    
    init(withViewModel viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
        }
        
        configureSubviews()
    }
    
    func configureSubviews() {
        let personalityType = viewModel.getPersonalityType()
        resultsLabel.text = Strings.resultsScore + "\n" + Strings.resultsIntrovertPoints + " \(viewModel.getPersonalityPoints().introvertPoints)" + "\n" + Strings.resultsExtrovertPoints + " \(viewModel.getPersonalityPoints().extrovertPoints)"
        
        var descriptionString = Strings.resultsDescription

        switch personalityType {
        case .introvert:
            descriptionString.append(Strings.resultsDescriptionIntrovert)
        case .extrovert:
            descriptionString.append(Strings.resultsDescriptionExtrovert)
        case .both:
            descriptionString.append(Strings.resultsDescriptionMiddle)
        }
        
        resultsDescriptionLabel.text = descriptionString
    }
    
    @objc func retakeTestButtonTapped() {
        delegate?.retakeTest()
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
