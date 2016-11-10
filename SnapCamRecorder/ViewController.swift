//
//  ViewController.swift
//  SnapCamRecorder
//
//  Created by Ali Bamohammad on 09/11/16.
//  Copyright © 2016 Clickapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var circleButton: UIButton!
    @IBOutlet var vwRecored: UIView!
    var circle: CAShapeLayer!
    var circleLayer: CAShapeLayer!
    var drawAnimation: CABasicAnimation!
   
    let buttnSize:CGFloat = 70
    //@IBOutlet var vwCircle: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vwRecored.alpha = 0
        configureCircle()
    }

    
    func configureCircle() {
        
//        self.VwRecored.layer.cornerRadius = self.VwRecored.frame.size.width / 2
//        self.VwRecored.clipsToBounds = true
        let radius:CGFloat = 33
        self.circle = CAShapeLayer()
        
        // Make a circular shape
        self.circle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0), cornerRadius: CGFloat(radius)).cgPath
       
        
        self.circleButton.frame.size = CGSize(width: buttnSize, height: buttnSize)
        
        // Configure the apperence of the red circle
       /* self.vwRecored.alpha = 0.0
        self.vwRecored.frame.size = CGSize(width: buttnSize , height: buttnSize  )
        self.vwRecored.layoutIfNeeded()
        self.vwRecored.layer.cornerRadius = self.vwRecored.frame.size.width / 2
                self.vwRecored.clipsToBounds = true
        */
        
        self.circle.position =  CGPoint (x: self.circleButton.frame.midX - radius, y: self.circleButton.frame.midY - radius)
        
        //(x: self.circleButton.frame.origin.x + 10 , y: self.circleButton.frame.origin.y + 10)
        
        // Configure the apperence of the circle
        self.circle.fillColor = UIColor.clear.cgColor
        self.circle.strokeColor = UIColor.red.cgColor
        self.circle.lineWidth = 5
        
        self.circle.strokeEnd = 0
        
        // Configure the apperence of the circleButton
        
        self.circleButton.tintColor = UIColor.gray
        
        
        // Add to parent layer
        self.circleButton.layer.addSublayer(self.circle)
        
        // Target for touch down (hold down)
        self.circleButton.addTarget(self, action:#selector (startCircleAnimation(sender:)), for: UIControlEvents.touchDown)
        
        // Target for release
        self.circleButton.addTarget(self, action:#selector (endCircleAnimation(sender:)), for: UIControlEvents.touchUpInside)
        self.circleButton.addTarget(self, action:#selector (endCircleAnimation(sender:)), for: UIControlEvents.touchUpOutside)
        
        
        // add record cercl
        circleLayer = CAShapeLayer()
        let recordRadius: CGFloat = 25
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * recordRadius, height: 2.0 * recordRadius)  , cornerRadius: recordRadius).cgPath
        circleLayer.position = CGPoint(x: self.circleButton.frame.midX - recordRadius, y: self.circleButton.frame.midY - recordRadius)
        circleLayer.fillColor = UIColor.red.cgColor
        self.circleButton.layer.addSublayer(self.circleLayer)
        
    }
    
    func circleAnimation() {
        
        // Configure animation
        self.drawAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        self.drawAnimation.duration = 6.0
        self.drawAnimation.repeatCount = 1.0    // Animate only once..
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        self.drawAnimation.fromValue = 0.0
        
        // Set your to value to one to complete animation
        self.drawAnimation.toValue = 1.0
        
        self.drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.circle.add(self.drawAnimation, forKey: "draw")
        
        vwRecored.alpha = 0

        /*
         var frame = CGRect(x: self.circleButton.frame.origin.x - 5, y: self.circleButton.frame.origin.y - 5, width: self.circleButton.frame.size.width + 5, height: self.circleButton.frame.size.height + 5)
        */
         //self.vwRecored.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.7, animations: {
            
           self.circleButton.transform = CGAffineTransform(scaleX: 1.15,y: 1.15);
            //self.vwRecored.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            }, completion: nil)
        
 
    }
    
    func startCircleAnimation(sender : UIButton) {

            circleAnimation()
        print("Recording started")

    }
    
    func completeCircleAnimation(sender : UIButton) {
        
        self.circle.removeAllAnimations()
        print("completeCircleAnimation finshed")
        
    }
    func endCircleAnimation(sender : UIButton) {
        
        self.circle.removeAllAnimations()
        print("Recording finshed")
        UIView.animate(withDuration: 0.5, animations: {
            
            self.circleButton.transform = CGAffineTransform(scaleX: 1,y: 1);
            //self.vwRecored.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            }, completion: { (finished) -> Void in
                // ....
               // self.vwRecored.alpha = 0
                
        })
        
    }
 


}

