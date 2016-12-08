//
//  ViewController.swift
//  SnapCamRecorder
//
//  Created by Ali Bamohammad on 09/11/16.
//  Copyright © 2016 Clickapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet var circleButton: UIButton!
    
    @IBOutlet var vwRecored: UIView!
    
    var circle: CAShapeLayer!
    var buttonBorder: CAShapeLayer!
    var recoredCircleLayer: CAShapeLayer!
    
    var drawAnimation: CABasicAnimation!
    let buttnSize:CGFloat = 70

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCircle()
    }
    
    func configureCircle() {
        

        let radius:CGFloat = 35
        self.circle = CAShapeLayer()
        self.buttonBorder = CAShapeLayer()
        
        // Make a circular shape
        self.circle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
        // Make a circular border
        self.buttonBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
       
        
        self.circleButton.frame.size = CGSize(width: buttnSize, height: buttnSize)
        
        //  make button in circl shape
        self.circleButton.layer.cornerRadius = self.circleButton.bounds.width / 2
        self.circleButton.clipsToBounds = true

        
        self.circle.position =  CGPoint (x: self.circleButton.frame.midX - radius, y: self.circleButton.frame.midY - radius)
        self.buttonBorder.position =  CGPoint (x: self.circleButton.frame.midX - radius, y: self.circleButton.frame.midY - radius)

        // Configure the apperence of the circle
        self.circle.fillColor = UIColor.clear.cgColor
        self.circle.strokeColor = UIColor.red.cgColor
        self.circle.lineWidth = 5
        
        self.circle.strokeEnd = 0.6
        
        
        // Configure the apperence of the button burder
        self.buttonBorder.fillColor = UIColor.clear.cgColor
        self.buttonBorder.strokeColor = UIColor.lightGray.cgColor
        self.buttonBorder.lineWidth = 5
        
        
        // Configure the apperence of the circleButton
        
        //self.circleButton.tintColor = UIColor.gray
        
        
        // Add to parent layer
        self.circleButton.layer.addSublayer(self.buttonBorder)
        self.circleButton.layer.addSublayer(self.circle)
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.addTarget(self, action: #selector(startCircleAnimation(gesture:)))
        self.circleButton.addGestureRecognizer(longPressGesture)
        
        // Target for release
        
        // Target for release
       // self.circleButton.addTarget(self, action:#selector (endCircleAnimation(sender:)), for: UIControlEvents.touchUpInside)
        //self.circleButton.addTarget(self, action:#selector (endCircleAnimation(sender:)), for: UIControlEvents.touchUpOutside)
        
        
        // add record cercl
        recoredCircleLayer = CAShapeLayer()
        let recordRadius: CGFloat = 25
        recoredCircleLayer.path = UIBezierPath(roundedRect: CGRect(x: 25, y: 25, width: 0 , height: 0 )  , cornerRadius: 25).cgPath
            
        
        recoredCircleLayer.position = CGPoint(x: self.circleButton.frame.midX - recordRadius, y: self.circleButton.frame.midY - recordRadius)
        recoredCircleLayer.fillColor = UIColor.red.cgColor
        self.circleButton.layer.addSublayer(self.recoredCircleLayer)
        
    }
    
    
    func circleAnimation() {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ (finished) -> Void in
           
//             self.circle.removeAllAnimations()
//            self.recoredCircleLayer.removeAllAnimations()
            
            self.endCircleAnimation(sender:self.circleButton)
            print("don anmatioin")
            
            
        })
        
        self.drawAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        self.drawAnimation.duration = 6.0
        self.drawAnimation.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        self.drawAnimation.fromValue = 0.0
        
        // Set your to value to one to complete animation
        self.drawAnimation.toValue = 1.0
        
        self.drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.circle.add(self.drawAnimation, forKey: "draw")
        
        CATransaction.commit()
        
       
        
        // Configure animation for recored circle
       /* let fromValue = 50.0
        let toValue =  0
        CATransaction.setDisableActions(true)
        self.recoredCircleLayer.bounds.size.height = CGFloat(toValue)
        let positionAnimation = CABasicAnimation(keyPath: "path")
        positionAnimation.fromValue = fromValue
        positionAnimation.toValue = toValue
        positionAnimation.duration = 6.0
        positionAnimation.repeatCount = 1
        self.recoredCircleLayer.add(positionAnimation, forKey: "bounds")
       */
        
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = recoredCircleLayer.path
        expandAnimation.toValue =  UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 50)  , cornerRadius: 25).cgPath //recoredCircleLayer.path
        expandAnimation.duration = 1
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        self.recoredCircleLayer.add(expandAnimation, forKey: nil)

        
 
    }
    
    func startCircleAnimation(gesture:UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            
            endCircleAnimation(sender:self.circleButton)
        }
        else if gesture.state == .began {
            UIView.animate(withDuration: 0.5, animations: {
                
                self.circleButton.transform = CGAffineTransform(scaleX: 1.15,y: 1.15);
                
            }, completion: { (finished) -> Void in
            })
            circleAnimation()
            print("Recording started")
        }
    }
    
    func completeCircleAnimation(sender : UIButton) {
        
        self.circle.removeAllAnimations()
        print("completeCircleAnimation finshed")
        
    }
    func endCircleAnimation(sender : UIButton) {
        
        self.circle.removeAllAnimations()
        self.recoredCircleLayer.removeAllAnimations()
        print("Recording finshed")
        UIView.animate(withDuration: 0.5, animations: {
            
            self.circleButton.transform = CGAffineTransform(scaleX: 1,y: 1);
           
            
            }, completion: { (finished) -> Void in

                
        })
        
    }
 


}

