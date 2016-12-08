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
    var progressCircles: CAShapeLayer!
    
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
    
    
    
   
    @IBInspectable var progressBorderColor: UIColor = UIColor.red {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var progressBorderWidth: CGFloat = 5.0 {
        didSet {
            self.configureProgressCircle()
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var btnBorderWidth: CGFloat = 5.0 {
        didSet {
            self.configureProgressCircle()
        }
    }
    @IBInspectable var bcakgroundColor:  UIColor = UIColor.clear {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var buttnSize:  CGFloat = 75.0 {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var recoredCircleLayerColor:  UIColor = UIColor.red {
        didSet {
            self.configureProgressCircle()
        }
    }
    
    @IBInspectable var RecorderTimer:  CGFloat = 6.0 {
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
    
    
    override func prepareForInterfaceBuilder() {
        
        
    }
    
    private func configureProgressCircle() {
        
        // setup initanal settings
        let radius:CGFloat = buttnSize / 2
        
        self.frame.size = CGSize(width: buttnSize, height: buttnSize)
        
        self.layer.sublayers?.removeAll()
        
        // add buttnBorder
        buttonBorder = CAShapeLayer()
        
        // Make buttnBorder circular shape
        buttonBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the buttnBorder
        buttonBorder.fillColor = UIColor.clear.cgColor
        buttonBorder.strokeColor = UIColor.lightGray.cgColor
        buttonBorder.lineWidth = self.btnBorderWidth
        buttonBorder.strokeEnd = 1
        self.layer.addSublayer(buttonBorder)
        
        
        
        
        // create recorder timer
        progressCircles = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressCircles.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircles.fillColor = UIColor.clear.cgColor
        progressCircles.strokeColor = UIColor.white.cgColor
        progressCircles.lineWidth = self.progressBorderWidth
        progressCircles.strokeEnd = 0.507
        self.layer.addSublayer(progressCircles)
        
        // create recorder timer
        progressCircle = CAShapeLayer()
        
        // Make a progressCircle circular shape
        progressCircle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        
        // Configure the apperence of the progressCircle
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.strokeColor = self.progressBorderColor.cgColor
        progressCircle.lineWidth = self.progressBorderWidth
        progressCircle.strokeEnd = 0.5
        self.layer.addSublayer(progressCircle)
        //buttonBorder
        
        recoredCircleLayer = CAShapeLayer()
        let recordRadius = (buttnSize / 3)
        recoredCircleLayer.path = UIBezierPath(roundedRect: CGRect(x: recordRadius, y: recordRadius, width: 0  , height: 0  )  , cornerRadius: recordRadius).cgPath
        
        
        recoredCircleLayer.position = CGPoint(x: (buttnSize / 2) - recordRadius, y: (buttnSize / 2) - recordRadius)
        recoredCircleLayer.fillColor = recoredCircleLayerColor.cgColor
        
        self.layer.addSublayer(recoredCircleLayer)
        
        //self.progressCircleAnimation()
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.addTarget(self, action: #selector(recoredVideo(gesture:)))
        
        
        
        let tapPressGesture = UITapGestureRecognizer()
    
        tapPressGesture.addTarget(self, action: #selector(takePhoto(gesture:)))
        
        
        
        self.addGestureRecognizer(longPressGesture)
        self.addGestureRecognizer(tapPressGesture)
        
    }
    
    private func progressCircleAnimation () {
    
         drawProgressCircle = CABasicAnimation()
        CATransaction.begin()
        CATransaction.setCompletionBlock({ (finished) -> Void in
            
            print("don anmatioin")
            self.endCircleAnimation(sender:self)
            
        })
        
        drawProgressCircle = CABasicAnimation.init(keyPath: "strokeEnd")
        drawProgressCircle.duration = CFTimeInterval(self.RecorderTimer)
        drawProgressCircle.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawProgressCircle.fromValue = 0.0
        
        // Set your to value to one to complete animation
        drawProgressCircle.toValue = 1.0
        
        drawProgressCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        progressCircle.add(drawProgressCircle, forKey: "draw")
        
        CATransaction.commit()
        // video recorder circle animation
        let expandAnimation: CABasicAnimation = CABasicAnimation.init(keyPath: "path")
        expandAnimation.fromValue = recoredCircleLayer.path
        let recordRadius = (buttnSize / 3)
        expandAnimation.toValue =  UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: recordRadius * 2 , height: recordRadius * 2)  , cornerRadius: recordRadius).cgPath
        expandAnimation.duration = 1
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        self.recoredCircleLayer.add(expandAnimation, forKey: "path")
    
    }
    
    func recoredVideo(gesture:UILongPressGestureRecognizer) {
        print("recoredVideo started")
        if gesture.state == .ended {
            
            endCircleAnimation(sender:self)
        }
        else if gesture.state == .began {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.transform = CGAffineTransform(scaleX: 1.15,y: 1.15);
                
            }, completion: { (finished) -> Void in
            })
            progressCircleAnimation()
            print("Recording started")
        }
    }
    
    func takePhoto(gesture:UILongPressGestureRecognizer) {
        
        print("Photo taked")

    }

    func endCircleAnimation(sender : UIButton) {
        
        self.progressCircle.removeAllAnimations()
        self.recoredCircleLayer.removeAllAnimations()
        print("Recording finshed")
        UIView.animate(withDuration: 0.5, animations: {
            
            self.transform = CGAffineTransform(scaleX: 1,y: 1);
            
            
            }, completion: { (finished) -> Void in
                
                
        })
        
    }
    
    
}
