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
            //self.configureProgressCircle()
        }
    }
    @IBInspectable var borderCircleColor:  UIColor = UIColor.gray {
        didSet {
             //self.configureProgressCircle()
        }
        
    }
    @IBInspectable var backgorundCircleColor:  UIColor = UIColor.gray {
        didSet {
            //self.configureProgressCircle()
        }
        
    }
    @IBInspectable var borderWidth: CGFloat = 5.0 {
        didSet {
            //self.configureProgressCircle()
        }
    }
    
    @IBInspectable var endProgress: CGFloat = 0.5 {
        didSet {
            //self.configureProgressCircle()
        }
    }
    
    //progressAngle
    @IBInspectable var viewSize:  CGFloat = 75.0 {
        didSet {
           // self.configureProgressCircle()
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
        
        //self.configureProgressCircle()
            
            self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
            
            self.drowCircle(strokeStart: 0, strokeEnd: 0.3, color: UIColor.red)
            
            self.drowCircle(strokeStart: 0.31, strokeEnd: 0.5, color: UIColor.blue)
            
            self.drowCircle(strokeStart: 0.51, strokeEnd: 0.7, color: UIColor.green)
            
            self.drowCircle(strokeStart: 0.71, strokeEnd: 0.99, color: UIColor.brown)
            

        }
    public func drowCircle(strokeStart: CGFloat , strokeEnd: CGFloat , color: UIColor) {
        
        let radius:CGFloat = viewSize / 2
        
        self.frame.size = CGSize(width: viewSize, height: viewSize)
        
        let progressCircle = CAShapeLayer()

        progressCircle.path = UIBezierPath(arcCenter: CGPoint(x: radius,y: radius), radius: radius, startAngle: CGFloat(-0.5), endAngle:CGFloat(M_PI * 2 - 0.5), clockwise: true).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.strokeColor = color.cgColor
        progressCircle.lineWidth = self.borderWidth
        
        progressCircle.strokeStart = strokeStart
        progressCircle.strokeEnd = strokeEnd
        self.layer.addSublayer(progressCircle)
        
        drawProgressCircle = CABasicAnimation()
        
        drawProgressCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawProgressCircle.duration = 1
        drawProgressCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawProgressCircle.fromValue = strokeStart
        
        // Set your to value to one to complete animation
        drawProgressCircle.toValue = strokeEnd
        
        drawProgressCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressCircle.add(drawProgressCircle, forKey: "draw")
        
    }
    /*
    public func configureProgressCircle() {
        
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
        progressBorderCircles.path = UIBezierPath(arcCenter: CGPoint(x: radius,y: radius), radius: radius, startAngle: CGFloat(-0.5), endAngle:CGFloat(M_PI * 2 - 0.5), clockwise: true).cgPath
        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2));

        // Configure the apperence of the progressCircle
        progressBorderCircles.fillColor = UIColor.clear.cgColor
        progressBorderCircles.strokeColor = backgorundCircleColor.cgColor
        progressBorderCircles.lineWidth = self.borderWidth
        
        progressBorderCircles.strokeEnd = endProgress
        self.layer.addSublayer(progressBorderCircles)
    
        // create recorder timer
        progressCircle = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressCircle.path = UIBezierPath(arcCenter: CGPoint(x: radius,y: radius), radius: radius, startAngle: CGFloat(-0.5), endAngle:CGFloat(M_PI * 2 - 0.5), clockwise: true).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.strokeColor = self.progressCircleColor.cgColor
        progressCircle.lineWidth = self.borderWidth
        
        progressCircle.strokeStart = 0.01
        progressCircle.strokeEnd = endProgress - 0.01
        self.layer.addSublayer(progressCircle)

        progressCircleAnimation()
    }
    
    public func progressCircleAnimation () {
        
        drawProgressCircle = CABasicAnimation()

        drawProgressCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawProgressCircle.duration = 1
        drawProgressCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawProgressCircle.fromValue = 0.01
        
        // Set your to value to one to complete animation
        drawProgressCircle.toValue = endProgress - 0.01
        
        drawProgressCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressCircle.add(drawProgressCircle, forKey: "draw")

        drawprogressBorderCircle = CABasicAnimation()
        drawprogressBorderCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawprogressBorderCircle.duration = 1
        drawprogressBorderCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawprogressBorderCircle.fromValue = 0.0
        
        // Set your to value to one to complete animation
        drawprogressBorderCircle.toValue = endProgress
        
        drawprogressBorderCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressBorderCircles.add(drawprogressBorderCircle, forKey: "draw")
    }
*/
}
