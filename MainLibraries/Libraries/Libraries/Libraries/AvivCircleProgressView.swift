//
//  FullProgressView.swift
//  TestXtend
//
//  Created by Max Bolotov on 3/2/20.
//  Copyright © 2020 Sodexo. All rights reserved.
//

import UIKit
import UICircularProgressRing

protocol AvivCircleProgressViewDelegate: class {
    func didFinishProgressAnimation()
}

private struct CircleConstants {
    static let animationDuration: TimeInterval = 2.0
    static let counterSize: CGSize = CGSize(width: 90, height: 70)
}

class AvivCircleProgressView: UIView {
    
    weak var delegate: AvivCircleProgressViewDelegate?
    
    @IBOutlet weak var progressRing: UICircularProgressRing?
    var digitCounter: DigitScrollCounter?
    var outOfLabel: UILabel?
    
    var currentValue: CGFloat = 0.0
    var minValue: CGFloat = 0.0
    var maxValue: CGFloat = 0.0
    var showProgressAnimated = false
    var changeStateAnimated = false
    var state: ProgressViewState = .full {
        didSet {
            self.refreshLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.progressRing?.minValue = self.minValue
        self.progressRing?.style = .ontop
        self.progressRing?.shouldShowValueText = false
        self.progressRing?.shouldDrawMinValueKnob = true
        self.setupProgressElements()
    }
    
    // MARK: - Setup
    
    func setup(maxValue: CGFloat, currentValue: CGFloat) {
        self.currentValue = currentValue
        self.maxValue = maxValue
        self.progressRing?.maxValue = maxValue
        self.setupDigitCounterIfNeeded()
        self.setProgressIfNeeded()
    }
    
    func setupDigitCounterIfNeeded() {
        
        if self.digitCounter == nil {
                   
            self.digitCounter = DigitScrollCounter(min: Int(minValue), max:  Int(maxValue), font: UIFont.xtendRegularFont(ofSize: self.state.counterFontSize()), textColor: UIColor.xtendDeepSkyBlue, backgroundColor: .clear, scrollDuration: CircleConstants.animationDuration)
            self.progressRing?.addSubview(self.digitCounter!)
            self.digitCounter?.snp.makeConstraints { (make) in
                if let ring = self.progressRing {
                    make.centerX.equalTo(ring)
                    make.centerY.equalTo(ring).offset(self.state.counterCenterOffset())
                }
                make.width.equalTo(CircleConstants.counterSize.width)
                make.height.equalTo(CircleConstants.counterSize.height)
            }
            
            let outOfLabel = UILabel(frame: CGRect.zero)
            outOfLabel.text = "Out of \(Int(maxValue))"
            outOfLabel.font = UIFont.xtendRegularFont(ofSize: 19)
            outOfLabel.textAlignment = .center
            outOfLabel.sizeToFit()
            outOfLabel.textColor = UIColor.xtendTextGray
            outOfLabel.backgroundColor = .clear
            self.outOfLabel = outOfLabel
            self.progressRing?.addSubview(outOfLabel)
            
            outOfLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.digitCounter!.snp_bottomMargin).offset(10)
                make.centerX.equalTo(self.digitCounter!)
            }
            self.updateLayout()
        }
    }
    
    func setupProgressElements() {
        self.progressRing?.valueKnobStyle = UICircularRingValueKnobStyle(size: self.state.knobSize(), color: UIColor.xtendDeepSkyBlue)
        self.progressRing?.innerRingWidth = self.state.ringWith()
        self.progressRing?.outerRingWidth = self.state.ringWith()
    }
    
    func setProgressIfNeeded() {
        if !showProgressAnimated {
            self.progressRing?.value = currentValue
            self.digitCounter?.scrollToItem(atIndex: Int(currentValue), animated: false)
        }
    }
    
    func refreshLayout() {
        if self.changeStateAnimated {
            self.updateLayoutAnimated()
        } else {
            self.setupProgressElements()
            self.updateLayout()
        }
    }
    
    func updateLayout() {
        self.outOfLabel?.alpha = self.state.outLabelAlpha()
        self.digitCounter?.transform = CGAffineTransform(scaleX: self.state.counterScale(), y: self.state.counterScale())
        self.digitCounter?.snp.updateConstraints({ (make) in
            if let ring = self.progressRing {
                make.centerY.equalTo(ring).offset(self.state.counterCenterOffset())
            }
        })
    }
    
    func updateLayoutAnimated() {
        // Update progress after small delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setupProgressElements()
        }
        UIView.animate(withDuration: 0.5) {
            self.updateLayout()
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Animation
    
    func startProgressAnimation() {
        self.digitCounter?.scrollToItem(atIndex: Int(self.currentValue))
        self.progressRing?.resetProgress()
        self.progressRing?.startProgress(to: self.currentValue, duration: CircleConstants.animationDuration) {
            self.delegate?.didFinishProgressAnimation()
        }
    }
}


