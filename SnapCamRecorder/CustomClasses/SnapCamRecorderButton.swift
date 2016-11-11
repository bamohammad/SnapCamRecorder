//
//  SnapCamRecorderButton.swift
//  SnapCamRecorder
//
//  Created by Ali Bamohammad on 11/11/16.
//  Copyright © 2016 Clickapps. All rights reserved.
//

import UIKit
@IBDesignable class SnapCamRecorderButton: UIButton {
    
    /**
     @var progressCircle
     @description record progress
     
     */
    var progressCircle: CAShapeLayer!
    
    /**
     @var borderCircle
     @description button border
     
     */
    var buttonBorder: CAShapeLayer!
    
    /**
     @var recoredCircleLayer
     @description circle show in the midle when recoreding
     
     */
    var recoredCircleLayer: CAShapeLayer!
    
    var drawProgressCircle: CABasicAnimation!
    let borderWidth = 6
    
    
    
   /*
    @IBInspectable var progressBorderColor: UIColor = UIColor.red {
        didSet {
            layer.borderColor = progressBorderColor.cgColor
        }
    }
    
    @IBInspectable var progressBorderWidth: CGFloat = 5.0 {
        didSet {
            layer.borderWidth = progressBorderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 5.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var bcakgroundColor:  UIColor = UIColor.clear {
        didSet {
            layer.backgroundColor = bcakgroundColor.cgColor
        }
    }
    */
    @IBInspectable var buttnSize:  CGFloat = 75.0  {
        didSet {
            
            layer.bounds.size = CGSize(width: buttnSize, height: buttnSize)
        }
    }
    
 
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
    }
    
    
    
    override init(frame: CGRect) {
        NSLog("initWithFrame");
        super.init(frame: frame)
        
        //self.backgroundColor = UIColor.red
        self.configureProgressCircle()
        //_setup()
    }
    
    required init(coder: NSCoder) {
        NSLog("initWithCoder");
        super.init(coder: coder)!
        // put config function here
        
        self.layer.bounds.size = CGSize(width: buttnSize, height: buttnSize)
        self.configureProgressCircle()
        self.progressCircleAnimation()
       
        
    }
    
    override func prepareForInterfaceBuilder() {
        
        
        
    }
    
    private func configureProgressCircle() {
        
        let radius:CGFloat = buttnSize / 2
        
        // add buttnBorder
        buttonBorder = CAShapeLayer()
        
        // Make buttnBorder circular shape
        buttonBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the buttnBorder
        buttonBorder.fillColor = UIColor.clear.cgColor
        buttonBorder.strokeColor = UIColor.lightGray.cgColor
        buttonBorder.lineWidth = CGFloat(borderWidth)
        buttonBorder.strokeEnd = 1
        self.layer.addSublayer(buttonBorder)
        
        // add progressCircle
        progressCircle = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressCircle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.strokeColor = UIColor.red.cgColor
        progressCircle.lineWidth = CGFloat(borderWidth)
        progressCircle.strokeEnd = 0
        self.layer.addSublayer(progressCircle)
        //buttonBorder
        
        
        
    }
    
    private func progressCircleAnimation () {
    
         drawProgressCircle = CABasicAnimation()
        CATransaction.begin()
        CATransaction.setCompletionBlock({ (finished) -> Void in
            
            print("don anmatioin")
            
            
        })
        
        drawProgressCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawProgressCircle.duration = 6.0
        drawProgressCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawProgressCircle.fromValue = 0.0
        
        // Set your to value to one to complete animation
        drawProgressCircle.toValue = 1.0
        
        drawProgressCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressCircle.add(drawProgressCircle, forKey: "draw")
        
        CATransaction.commit()
    
    }
    
    
    
    
}
