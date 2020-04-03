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
    
    var pan = UIPanGestureRecognizer()
    var longPress = UILongPressGestureRecognizer()
    
    init(backgroundColor: UIColor, center: CGPoint) {
        let size: CGFloat = 100
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        self.center = center
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = size * 0.5
        
        pan.addTarget(self, action: #selector(handlePan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        
        longPress.addTarget(self, action: #selector(handleLongPress(_:)))
        longPress.delegate = self
        self.addGestureRecognizer(longPress)
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
        if longPress.state == .changed {
            switch pan.state {
            case .changed:
                circle.center.x += translation.x
                circle.center.y += translation.y
                pan.setTranslation(.zero, in: circle)
            default:
                return
            }
        }
    }
    
    @objc func handleLongPress(_ press: UILongPressGestureRecognizer) {
        guard let view = press.view else { return }
        let circle = view as! UICircleView
        
        switch press.state {
        case .began:
            circle.onSelect()
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

extension UICircleView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (gestureRecognizer == longPress && otherGestureRecognizer == pan)
    }
}
