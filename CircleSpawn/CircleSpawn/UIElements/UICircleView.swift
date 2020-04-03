//
//  UICircleView.swift
//  CircleSpawn
//
//  Created by Krystian Duma on 01/04/2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import Foundation
import UIKit

class UICircleView: UIView {
    init(backgroundColor: UIColor, center: CGPoint) {
        let size: CGFloat = 100
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        self.center = center
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = size * 0.5
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(pan)
    }

    func easeIn() {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: {  [weak self] completed in
            UIView.animate(withDuration: 0.1, animations: {
                self?.transform = .identity
            })
        })
    }

    func easeOut(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: completion)
    }
    
    func onSelect() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.5
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
    
    func onSelectDismissed() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @objc func handlePan(_ pan: UIPanGestureRecognizer) {
        guard  let view = pan.view else { return }
        let circle = view as! UICircleView
        let translation = pan.translation(in: view)
        
        switch pan.state {
        case .began:
            circle.onSelect()
        case .changed:
            circle.center.x += translation.x
            circle.center.y += translation.y
            pan.setTranslation(.zero, in: circle)
        case .ended, .cancelled:
            circle.onSelectDismissed()
        default:
            return
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
