//
//  ViewController.swift
//  HW #3 zoomAnimation
//
//  Created by Евгений Л on 07.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var animator    = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut)
    let viewSquares = UIView()
    let sliders     = UISlider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        subviewAddView()
        locationAnimationSetup()
        addTarget()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        sizeFrame()
    }
    
    //MARK: - visual part view
    func setupUI() {
        viewSquares.layer.cornerRadius = 10
        viewSquares.backgroundColor    = .systemBlue
        
        animator.pausesOnCompletion    = true
    }
    
    //MARK: - addition at view
    func subviewAddView() {
        [viewSquares, sliders].forEach {
            view.addSubview($0)
        }
    }
    
    //MARK: - sizes
    func sizeFrame() {
        if viewSquares.transform == .identity {
            self.viewSquares.frame.origin.x = self.view.frame.width - self.view.layoutMargins.left - self.viewSquares.frame.width
            
            viewSquares.frame = .init(x: view.layoutMargins.left,
                                      y: 100,
                                      width: 70,
                                      height: 70)
            
            sliders.frame = .init(x: view.layoutMargins.left,
                                  y: viewSquares.frame.maxY + 40,
                                  width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right,
                                  height: 40)

            sliders.sizeToFit()
        }
    }
    
    //MARK: - target
    func addTarget() {
        sliders.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        sliders.addTarget(self, action: #selector(sliderTouchTracking), for: [.touchUpInside, .touchUpOutside])
    }
    
    func locationAnimationSetup() {
        animator.addAnimations {
            
            self.viewSquares.frame.origin.x = self.view.frame.width - self.view.layoutMargins.left - self.view.layoutMargins.right - self.viewSquares.frame.width
            self.viewSquares.transform = CGAffineTransform(rotationAngle: .pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
    }
    
    //MARK: - selector
    @objc
    func sliderValueChange(sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc
    func sliderTouchTracking() {
        sliders.setValue(1, animated: true)
        animator.startAnimation()
    }
}




