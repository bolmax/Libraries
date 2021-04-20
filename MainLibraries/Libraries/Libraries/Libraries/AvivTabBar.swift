//
//  ExtendTabBar.swift
//  TestXtend
//
//  Created by Max Bolotov on 2/28/20.
//  Copyright © 2020 Sodexo. All rights reserved.
//

import UIKit

enum AvivTabBarItem: Int {
    case myPlans, myTests
}

struct AvivTabConstants {
    static let tabBarHeight: CGFloat = 61.0
    static let animationDuration: TimeInterval = 0.4
    static let imageInset: CGFloat = 9.0
    static let buttonTopInset: CGFloat = 10.0
    static let buttonWidth: CGFloat = 150.0
    static let buttonHeight: CGFloat = 40.0
}

protocol AvivTabBarDelegate: class {
    func didTapTabButton(item: AvivTabBarItem)
}

class AvivTabBar: UITabBar, Mappable {
    
    weak var avivDelegate: AvivTabBarDelegate?
    
    var plansButton: UIButton?
    var testButton: UIButton?
    var indicatorView: UIView?
    
    override var selectedItem: UITabBarItem? {
        didSet {
            if let item = self.selectedItem, let index = self.items?.firstIndex(of: item), let tabBarItem = AvivTabBarItem(rawValue: index) {
                self.didSelectItem(tabBarItem)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func setupViews() {
        
        self.shadowImage = UIImage()
        self.barTintColor = .xtendVeryLightGrey
        
        let plansButton = RTLButton(type: .custom)
        plansButton.setTitle(self.text(for: ResourceMapping.SideMenuScreen.myPlan), for: .normal)
        plansButton.setTitleColor(.white, for: .selected)
        plansButton.setTitleColor(.xtendCharcoalGrey, for: .normal)
        plansButton.titleLabel?.font = UIFont.xtendBoldFont(ofSize: 18)
        plansButton.setImage(UIImage(named: "left-button-icon"), for: .normal)
        plansButton.setImage(UIImage(named: "left-button-selected-icon"), for: .selected)
        plansButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: AvivTabConstants.imageInset)
        plansButton.adjustsImageWhenHighlighted = false
        plansButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        self.plansButton = plansButton
        
        let testButton = RTLButton(type: .custom)
        testButton.setTitle(self.text(for: ResourceMapping.SideMenuScreen.myTest), for: .normal)
        testButton.setTitleColor(.white, for: .selected)
        testButton.setTitleColor(.xtendCharcoalGrey, for: .normal)
        testButton.titleLabel?.font = UIFont.xtendBoldFont(ofSize: 18)
        testButton.setImage(UIImage(named: "right-button-icon"), for: .normal)
        testButton.setImage(UIImage(named: "right-button-selected-icon"), for: .selected)
        testButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: AvivTabConstants.imageInset)
        testButton.adjustsImageWhenHighlighted = false
        testButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        self.testButton = testButton
        
        let indicationView = UIView(frame: CGRect.zero)
        indicationView.backgroundColor = .xtendDeepSkyBlue
        indicationView.layer.cornerRadius = AvivTabConstants.buttonHeight / 2
        self.addSubview(indicationView)
        self.indicatorView = indicationView
        
        self.addSubview(plansButton)
        self.addSubview(testButton)
        
        testButton.snp.makeConstraints { (make) in
            let width = UIScreen.main.bounds.width
            let centerX = Localize.isDirectionRightToLeft() ? width / 4 : width - width / 4
            make.top.equalTo(self.snp.top).inset(AvivTabConstants.buttonTopInset)
            make.centerX.equalTo(centerX)
            make.width.equalTo(AvivTabConstants.buttonWidth)
            make.height.equalTo(AvivTabConstants.buttonHeight)
        }
                    
        plansButton.snp.makeConstraints { (make) in
            let width = UIScreen.main.bounds.width
            let centerX = Localize.isDirectionRightToLeft() ? width - width / 4 : width / 4
            make.top.equalTo(self.snp.top).inset(AvivTabConstants.buttonTopInset)
            make.centerX.equalTo(centerX)
            make.width.equalTo(AvivTabConstants.buttonWidth)
            make.height.equalTo(AvivTabConstants.buttonHeight)
        }
    }
    
    func didSelectItem(_ item: AvivTabBarItem) {
        
        switch item {
        case .myPlans:
            self.plansButton?.isSelected = true
            self.testButton?.isSelected = false
            self.plansButton?.isUserInteractionEnabled = false
            self.testButton?.isUserInteractionEnabled = true
            if let button = self.plansButton {
                self.animateIndicator(to: button)
            }
        case .myTests:
            self.plansButton?.isSelected = false
            self.testButton?.isSelected = true
            self.plansButton?.isUserInteractionEnabled = true
            self.testButton?.isUserInteractionEnabled = false
            if let button = self.testButton {
                self.animateIndicator(to: button)
            }
        }
    }
}

// MARK: - Animation
extension AvivTabBar {
    
    func animateIndicator(to button: UIButton) {
        UIView.animate(withDuration: AvivTabConstants.animationDuration) {
            self.indicatorView?.snp.remakeConstraints { make in
                make.center.equalTo(button)
                make.width.height.equalTo(button)
            }
            self.layoutIfNeeded()
        }
    }
}

 // MARK: - Actions
extension AvivTabBar {
    
    @objc func didTapLeftButton(_ sender: UIButton) {
        self.avivDelegate?.didTapTabButton(item: .myPlans)
    }
       
    @objc func didTapRightButton(_ sender: UIButton) {
        self.avivDelegate?.didTapTabButton(item: .myTests)
    }
}
