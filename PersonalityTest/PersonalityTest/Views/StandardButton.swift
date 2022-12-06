//
//  StandardButton.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 2.12.22.
//

import UIKit

class StandardButton: UIButton {
    let cornerRadius: CGFloat = 10
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 50)
    }
    
    init(title: String, type: StandardButtonType) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 2
        switch type {
        case .fill:
            self.backgroundColor = .blue
            self.setTitleColor(.white, for: .normal)
        case .empty:
            self.backgroundColor = .white
            self.setTitleColor(.blue, for: .normal)
        }

        self.titleLabel?.textAlignment = .center
        AnimationUtility.addBounceOnTap(control: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setVisibility(value: Bool, animated: Bool) {
        if value != (self.alpha == 1) {
            if animated {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: [.allowUserInteraction, .allowAnimatedContent],
                               animations: { self.alpha = value ? 1 : 0
                                            self.isHidden = !value },
                               completion: nil
                )
            } else {
                self.alpha = value ? 1 : 0
                self.isHidden = !value
            }
        }
    }
}

extension StandardButton {
    func setupButtonForLastPage(isLastPage: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction) {
            if isLastPage {
                self.setTitle(Strings.buttonFinishTest, for: .normal)
                self.backgroundColor = .systemGreen
                self.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                self.setTitle(Strings.buttonNextQuestion, for: .normal)
                self.backgroundColor = .blue
                self.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
    
    func setButtonEnabled(isEnabled: Bool) {
        if isEnabled {
            self.isEnabled = true
            self.alpha = 1
        } else {
            self.isEnabled = false
            self.alpha = 0.5
        }
    }
}

enum StandardButtonType {
    case fill
    case empty
}
