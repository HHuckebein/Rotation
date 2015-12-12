//
//  ViewController.swift
//  Rotation
//
//  Created by Bernd Rabe on 02.12.15.
//  Copyright © 2015 RABE_IT Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var arrowView: ArrowView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var clockwiseSwitch: UISwitch!
    @IBOutlet weak var startAnimationButton: UIButton!
    
    // MARK: - Boiler Plate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfoLabel()
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag {
            startAnimationButton.enabled = true
        }
    }

    // MARK: - Actions
    
    @IBAction func animationAction(sender: UIButton) {
        sender.enabled = false
        rotation()
        isUp = !isUp
    }

    @IBAction func switchDidChange(sender: UISwitch) {
        updateInfoLabel()
    }

    // MARK: - Private API
    
    private var isUp = true
    private var canStartAnimation = true
    private let rAngle = CGFloat(M_PI)
    
    private lazy var upTransform: CATransform3D = {
        let upTransform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
        return upTransform
    }()
    
    private lazy var rAngleCW: CGFloat = {
        let rAngleCW = CGFloat(M_PI)
        return rAngleCW
    }()
    
    private func updateInfoLabel () {
        infoLabel.text = clockwiseSwitch.on ? "clockwise" : "counterclockwise"
    }
    
    private func rotation () {
        
            arrowView.layer.transform = isUp ? upTransform : CATransform3DIdentity
            arrowView.layer.addAnimation(rotationAnimation(), forKey: "transform")
    }
    
    private func rotationAnimation () -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        
        if clockwiseSwitch.on {
            animation.values = isUp ? [0,  rAngle/2,  rAngle] : [ rAngle,  rAngle/2, 0]
        } else {
            animation.values = isUp ? [0, -rAngle/2, -rAngle] : [-rAngle, -rAngle/2, 0]
        }
        
        animation.keyTimes = [0.0, 0.5, 1.0]
        animation.duration = 1
        animation.delegate = self

        return animation
    }
}

/** A label wich pushes the text value out of the screen when a new value is set. */
class FadeLabel: UILabel {
    override var text: String? {
        willSet {
            let transition      = CATransition()
            transition.type     = kCATransitionPush
            transition.subtype  = kCATransitionFromTop
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.duration = CATransaction.animationDuration()
            self.layer.addAnimation(transition, forKey: "TransitionAnimation")
        }
    }
}
