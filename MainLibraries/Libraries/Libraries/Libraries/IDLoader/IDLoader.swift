//
//  IDLoader.swift
//  IDLoadingView
//
//  Created by Tsahi Deri on 10/07/2016.
//  Copyright © 2016 IdeoDigital. All rights reserved.
//

import UIKit
import QuartzCore
import CoreGraphics


let loaderSpinnerMarginSide : CGFloat = 30.0
let loaderSpinnerMarginTop : CGFloat = 20.0
let loaderTitleMargin : CGFloat = 5.0


open class IDLoader: UIView {
    
    fileprivate var coverView : UIView?
    fileprivate var titleLabel : UILabel?
    fileprivate var loadingView : IDLoadingView?
    fileprivate var animated : Bool = true
    fileprivate var canUpdated = false
    fileprivate var title: String?
    fileprivate var speed = 1
    
    fileprivate var config : IDConfig = IDConfig() {
        didSet {
            self.loadingView?.config = config
        }
    }
    
    override open var frame : CGRect {
        didSet {
            self.update()
        }
    }
    
    class var sharedInstance: IDLoader {
        struct Singleton {
            static let instance = IDLoader(frame: CGRect(x: 0, y: 0, width: IDConfig().size, height: IDConfig().size))
        }
        return Singleton.instance
    }
    
    
    // MARK: - Initilization
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Usage
    
    
    open class func show(_ animated: Bool = true) {
        self.show(nil, animated: animated, topMargin: 0)
    }
    
    open class func show(_ animated: Bool, topMargin: Int) {
        self.show(nil, animated: animated, topMargin: topMargin)
    }
    
    open class func show(_ title: String?, animated: Bool = true) {
        self.show(title, animated: animated, topMargin: 0)
    }
    
    open class func show(_ title: String?, animated: Bool, topMargin: Int) {
        
        DispatchQueue.main.async {
            
            let currentWindow : UIWindow = UIApplication.shared.keyWindow!
            
            let loader = IDLoader.sharedInstance
            loader.canUpdated = true
            loader.animated = animated
            loader.title = title
            loader.update()
            
            let height : CGFloat = UIScreen.main.bounds.size.height
            let width : CGFloat = UIScreen.main.bounds.size.width
            let center : CGPoint = CGPoint(x: width / 2.0, y: height / 2.0 - CGFloat(topMargin))
            loader.center = center
            
            if (loader.superview == nil) {
                loader.coverView = UIView(frame: currentWindow.bounds)
                loader.coverView?.backgroundColor = loader.config.foregroundColor.withAlphaComponent(loader.config.foregroundAlpha)
                
                currentWindow.addSubview(loader.coverView!)
                currentWindow.addSubview(loader)
                loader.start()
            }
        }
    }
    
    open class func hide() {
        
        DispatchQueue.main.async {
            
            let loader = IDLoader.sharedInstance
            loader.stop()
        }
    }
    
    open class func setConfig(_ config : IDConfig) {
        
        let loader = IDLoader.sharedInstance
        loader.config = config
        loader.frame = CGRect(x: 0, y: 0, width: loader.config.size, height: loader.config.size)
    }
    
    
    // MARK: - Private methods

    
    fileprivate func setup() {
        
        self.alpha = 0
        self.update()
    }
    
    fileprivate func start() {
        
        self.loadingView?.start()
        
        if (self.animated) {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.alpha = 1
                self.coverView?.alpha = 1
                }, completion: { (finished) -> Void in
                    
            });
        } else {
            self.alpha = 1
            self.coverView?.alpha = 1
        }
    }
    
    fileprivate func stop() {
        
        if (self.animated) {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.alpha = 0
                self.coverView?.alpha = 0
                }, completion: { (finished) -> Void in
                    self.removeFromSuperview()
                    self.coverView?.removeFromSuperview()
                    self.loadingView?.stop()
            });
        } else {
            self.alpha = 0
            self.coverView?.alpha = 0
            self.removeFromSuperview()
            self.coverView?.removeFromSuperview()
            self.loadingView?.stop()
        }
    }
    
    fileprivate func update() {
        
        self.backgroundColor = self.config.backgroundColor
        self.layer.cornerRadius = self.config.cornerRadius
        let loadingViewSize = self.frame.size.width - (loaderSpinnerMarginSide * 2)
        
        if self.loadingView == nil {
            self.loadingView = IDLoadingView(frame: self.frameForSpinner())
            self.addSubview(self.loadingView!)
        } else {
            self.loadingView?.frame = self.frameForSpinner()
        }
        
        if self.titleLabel == nil {
            self.titleLabel = UILabel(frame: CGRect(x: loaderTitleMargin, y: loaderSpinnerMarginTop + loadingViewSize, width: self.frame.width - loaderTitleMargin*2, height: 42.0))
            self.addSubview(self.titleLabel!)
            self.titleLabel?.numberOfLines = 1
            self.titleLabel?.textAlignment = NSTextAlignment.center
            self.titleLabel?.adjustsFontSizeToFitWidth = true
        } else {
            self.titleLabel?.frame = CGRect(x: loaderTitleMargin, y: loaderSpinnerMarginTop + loadingViewSize, width: self.frame.width - loaderTitleMargin*2, height: 42.0)
        }
        
        self.titleLabel?.font = self.config.titleTextFont
        self.titleLabel?.textColor = self.config.titleTextColor
        self.titleLabel?.text = self.title
        
        self.titleLabel?.isHidden = self.title == nil
    }
    
    func frameForSpinner() -> CGRect {
        
        let loadingViewSize = self.frame.size.width - (loaderSpinnerMarginSide * 2)
        
        if self.title == nil {
            let yOffset = (self.frame.size.height - loadingViewSize) / 2
            return CGRect(x: loaderSpinnerMarginSide, y: yOffset, width: loadingViewSize, height: loadingViewSize)
        }
        return CGRect(x: loaderSpinnerMarginSide, y: loaderSpinnerMarginTop, width: loadingViewSize, height: loadingViewSize)
    }
    
    
    // MARK: - Loader View

    
    class IDLoadingView : UIView {
        
        fileprivate var speed : Int?
        fileprivate var lineWidth : Float?
        fileprivate var lineTintColor : UIColor?
        fileprivate var backgroundLayer : CAShapeLayer?
        fileprivate var isSpinning : Bool?
        
        fileprivate var config : IDConfig = IDConfig() {
            didSet {
                self.update()
            }
        }
        
        
        // MARK: - Initilization
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
        // MARK: - Setup loading view
        
        
        fileprivate func setup() {
            
            self.backgroundColor = UIColor.clear
            self.lineWidth = fmaxf(Float(self.frame.size.width) * 0.025, 1)
            self.speed = self.config.speed
            
            self.backgroundLayer = CAShapeLayer()
            self.backgroundLayer?.strokeColor = self.config.spinnerColor.cgColor
            self.backgroundLayer?.fillColor = self.backgroundColor?.cgColor
            self.backgroundLayer?.lineCap = kCALineCapRound
            self.backgroundLayer?.lineWidth = CGFloat(self.lineWidth!)
            self.layer.addSublayer(self.backgroundLayer!)
        }
        
        fileprivate func update() {
            
            self.lineWidth = self.config.spinnerLineWidth
            self.speed = self.config.speed
            
            self.backgroundLayer?.lineWidth = CGFloat(self.lineWidth!)
            self.backgroundLayer?.strokeColor = self.config.spinnerColor.cgColor
        }
        
        
        // MARK: - Draw Circle
 
        
        override func draw(_ rect: CGRect) {
            
            self.backgroundLayer?.frame = self.bounds
        }
        
        fileprivate func drawBackgroundCircle(_ partial : Bool) {
            
            let startAngle : CGFloat = CGFloat(Double.pi) / CGFloat(2.0)
            var endAngle : CGFloat = (2.0 * CGFloat(Double.pi)) + startAngle
            
            let center : CGPoint = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
            let radius : CGFloat = (CGFloat(self.bounds.size.width) - CGFloat(self.lineWidth!)) / CGFloat(2.0)
            
            let processBackgroundPath : UIBezierPath = UIBezierPath()
            processBackgroundPath.lineWidth = CGFloat(self.lineWidth!)
            
            if (partial) {
                endAngle = (1.8 * CGFloat(Double.pi)) + startAngle
            }
            
            processBackgroundPath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            self.backgroundLayer?.path = processBackgroundPath.cgPath;
        }
        

        // MARK: - Start and stop spinning

        
        fileprivate func start() {
            
            self.isSpinning? = true
            self.drawBackgroundCircle(true)
            
            let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0 as Double)
            rotationAnimation.duration = CFTimeInterval(speed!);
            rotationAnimation.isCumulative = true;
            rotationAnimation.repeatCount = HUGE;
            self.backgroundLayer?.add(rotationAnimation, forKey: "rotationAnimation")
        }
        
        fileprivate func stop() {
            
            self.drawBackgroundCircle(false)
            
            self.backgroundLayer?.removeAllAnimations()
            self.isSpinning? = false
        }
    }
    
    
    // MARK: - Loader config
    
    
    public struct IDConfig {
        
        /**
        *  Size of loader
        */
        public var size : CGFloat = 100.0
        
        /**
        *  Color of spinner view
        */
        public var spinnerColor = UIColor.white
        
        /**
         *  Spinner Line Width
         */
        public var spinnerLineWidth :Float = 2.0
        
        /**
        *  Color of title text
        */
        public var titleTextColor = UIColor.white
        
         /**
         *  Speed of the spinner
         */
        public var speed :Int = 1
        
        /**
        *  Font for title text in loader
        */
        public var titleTextFont : UIFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        /**
        *  Background color for loader
        */
        public var backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        /**
        *  Foreground color
        */
        public var foregroundColor = UIColor.clear
        
        /**
        *  Foreground alpha CGFloat, between 0.0 and 1.0
        */
        public var foregroundAlpha:CGFloat = 0.0
        
        /**
        *  Corner radius for loader
        */
        public var cornerRadius : CGFloat = 10.0
        
        public init() {}
        
    }
}
