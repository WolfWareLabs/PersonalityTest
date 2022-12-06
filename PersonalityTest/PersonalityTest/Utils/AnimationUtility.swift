//
//  AnimationUtility.swift
//  PersonalityTest
//
//  Created by WolfWare02 on 2.12.22.
//

import UIKit

class AnimationUtility {
    static func addBounceOnTap(control: UIControl) {
        control.addTarget(self, action: #selector(onBounceDown), for: .touchDown)
        control.addTarget(self, action: #selector(onBounceUp), for: .touchUpInside)
        control.addTarget(self, action: #selector(onBounceUp), for: .touchUpOutside)
        control.addTarget(self, action: #selector(onBounceUp), for: .touchCancel)
    }
    
    @objc static func onBounceDown(_ sender: UIView?) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .allowUserInteraction,
                       animations: { sender?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) },
                       completion: nil
        )
    }
    
    @objc static func onBounceUp(_ sender: UIView?) {
        sender?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.30),
                       initialSpringVelocity: CGFloat(16.0),
                       options: [.allowUserInteraction, .allowAnimatedContent],
                       animations: { sender?.transform = .identity },
                       completion: nil
        )
    }
}
