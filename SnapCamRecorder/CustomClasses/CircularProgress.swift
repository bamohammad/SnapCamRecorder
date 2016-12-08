//
//  CircularProgress.swift
//  SnapCamRecorder
//
//  Created by Ali Bamohammad on 08/12/16.
//  Copyright © 2016 Clickapps. All rights reserved.
//

import UIKit

@IBDesignable class CircularProgress: UIView {

    
    /**
     @var progressCircle
     @description record progress
     
     */
    var progressCircle: CAShapeLayer!
    
    var progressBorderCircles: CAShapeLayer!
    
    /**
     @var borderCircle
     @description button border
     
     */
    var viewBorder: CAShapeLayer!
    
    var  drawProgressCircle: CABasicAnimation!
    var  drawprogressBorderCircle: CABasicAnimation!
    
    
    @IBInspectable var progressCircleColor:  UIColor = UIColor.red {
        didSet {
            self.configureProgressCircle()
        }
    }
    @IBInspectable var borderCircleColor:  UIColor = UIColor.gray {
        didSet {
             self.configureProgressCircle()
        }
        
    }
    @IBInspectable var borderWidth: CGFloat = 5.0 {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var endProgress: CGFloat = 0.5 {
        didSet {
            self.configureProgressCircle()
        }
    }
    @IBInspectable var progressRotationAngle: CGFloat = 35 {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var progressAngle: CGFloat = 100 {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    //progressAngle
    @IBInspectable var viewSize:  CGFloat = 75.0 {
        didSet {
            self.configureProgressCircle()
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
        
        }
        
        required init(coder: NSCoder) {
        NSLog("initWithCoder");
        super.init(coder: coder)!
        
        self.configureProgressCircle()

        }
    
    
    private func configureProgressCircle() {
        
        // setup initanal settings
        let radius:CGFloat = viewSize / 2
        
        self.frame.size = CGSize(width: viewSize, height: viewSize)
        
        self.layer.sublayers?.removeAll()
        
        // add buttnBorder
        viewBorder = CAShapeLayer()
        
        // Make buttnBorder circular shape
        viewBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the buttnBorder
        viewBorder.fillColor = UIColor.clear.cgColor
        viewBorder.strokeColor = self.borderCircleColor.cgColor
        viewBorder.lineWidth = self.borderWidth
        viewBorder.strokeEnd = 1
        self.layer.addSublayer(viewBorder)
        
        
        
        
        // create recorder timer
        progressBorderCircles = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressBorderCircles.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath

       // progressBorderCircles.transform = makerotat //CATransform3DMakeRotation(30.0 / 180.0 * CGFloat.pi, 0.0, 0.0, 1.0)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2));
        // Configure the apperence of the progressCircle
        progressBorderCircles.fillColor = UIColor.clear.cgColor
        progressBorderCircles.strokeColor = UIColor.white.cgColor
        progressBorderCircles.lineWidth = self.borderWidth
        
        progressBorderCircles.strokeEnd = endProgress
        self.layer.addSublayer(progressBorderCircles)
        
        // create recorder timer
        progressCircle = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressCircle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.strokeColor = self.progressCircleColor.cgColor
        progressCircle.lineWidth = self.borderWidth
        
        progressCircle.strokeStart = 0.007
        progressCircle.strokeEnd = endProgress - 0.007
        self.layer.addSublayer(progressCircle)

        progressCircleAnimation()
    }
    
    private func progressCircleAnimation () {
        
        drawProgressCircle = CABasicAnimation()
    
        
        drawProgressCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawProgressCircle.duration = 2
        drawProgressCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawProgressCircle.fromValue = 0.007
        
        // Set your to value to one to complete animation
        drawProgressCircle.toValue = endProgress - 0.007
        
        drawProgressCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressCircle.add(drawProgressCircle, forKey: "draw")
        
   
        
        drawprogressBorderCircle = CABasicAnimation()
        drawprogressBorderCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawprogressBorderCircle.duration = 2
        drawprogressBorderCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawprogressBorderCircle.fromValue = 0.0
        
        // Set your to value to one to complete animation
        drawprogressBorderCircle.toValue = endProgress
        
        drawprogressBorderCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressBorderCircles.add(drawprogressBorderCircle, forKey: "draw")
    }

}
