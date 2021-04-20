//
//  BadgedButton.swift
//  Xtend
//
//  Created by Max Bolotov on 24.03.2020.
//  Copyright © 2020 Tsahi Deri. All rights reserved.
//

import UIKit

private struct Constants {
    static let badgeConteinerSize: CGSize = CGSize(width: 19, height: 19)
    static let badgeBackgroundSize: CGSize = CGSize(width: 15, height: 15)
}

@IBDesignable
class BadgedButton: AnimatableButton {
    
    var badgeCount: Int = 0 {
        didSet {
            self.setBadgeCountIfNeeded()
        }
    }
    
    @IBInspectable
    var badgeContainerColor: UIColor = .xtendVeryLightPink {
        didSet {
            self.badgeContainerView?.backgroundColor = badgeContainerColor
        }
    }
    
    @IBInspectable
    var badgeColor: UIColor = .xtendRed {
        didSet {
            self.badgeView?.backgroundColor = badgeColor
        }
    }
    
    @IBInspectable
    var centerXOffset: CGFloat = 13.0
      
    @IBInspectable
    var centerYOffset: CGFloat = 19.0
    
    @IBInspectable
    var canShowBadge: Bool = true
    
    
    private var badgeContainerView: UIView?
    private var badgeView: UIView?
    private var badgeLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupBadge()
        self.showBadge(false)
    }
    
    private func setupBadge() {
        
        let badgeContainer = UIView(frame: .zero)
        let badgeColorView = UIView(frame: .zero)
        let badgeCountLabel = UILabel(frame: .zero)
        
        badgeContainer.backgroundColor = self.badgeContainerColor
        badgeColorView.backgroundColor = self.badgeColor
        
        badgeContainer.fullyRound(diameter: Constants.badgeConteinerSize.width, borderColor: self.badgeContainerColor, borderWidth: 0)
        badgeColorView.fullyRound(diameter: Constants.badgeBackgroundSize.width, borderColor: self.badgeColor, borderWidth: 0)
        
        badgeCountLabel.textColor = .white
        badgeCountLabel.font = UIFont.xtendBoldFont(ofSize: 10)
        badgeCountLabel.textAlignment = .center
        
        self.addSubview(badgeContainer)
        badgeContainer.addSubview(badgeColorView)
        badgeColorView.addSubview(badgeCountLabel)
        
        self.badgeContainerView = badgeContainer
        self.badgeView = badgeColorView
        self.badgeLabel = badgeCountLabel
        
        badgeContainer.snp.makeConstraints { (make) in
            make.height.width.equalTo(Constants.badgeConteinerSize.width)
            make.centerY.equalToSuperview().offset(-self.centerYOffset)
            let centerXOffset = Localize.isDirectionRightToLeft() ? -self.centerXOffset : self.centerXOffset
            make.centerX.equalToSuperview().offset(centerXOffset)
        }
        
        badgeColorView.snp.makeConstraints { (make) in
            make.height.width.equalTo(Constants.badgeBackgroundSize.width)
            make.centerX.centerY.equalTo(badgeContainer)
        }
        
        badgeCountLabel.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension BadgedButton {
    
    private func setBadgeCountIfNeeded() {
        
        guard self.canShowBadge else {
            self.showBadge(false)
            return
        }
        
        self.showBadge(self.badgeCount > 0)
        self.setCountLabel()
    }
    
    private func setCountLabel() {
        let text = self.badgeCount > 9 ? "\("9+")" : "\(self.badgeCount)"
        self.badgeLabel?.text = text
    }
    
    private func showBadge(_ show: Bool) {
        self.badgeContainerView?.isHidden = !show
    }
    
}
