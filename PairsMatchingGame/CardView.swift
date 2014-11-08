//
//  CardView.swift
//  PairsMatchingGame
//
//  Created by yrom on 14-11-7.
//  Copyright (c) 2014年 yrom. All rights reserved.
//

import UIKit

class CardView: UIControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var card: Card? {
        didSet {
            if card != oldValue {
                frontLayer.contents = UIImage(named: card!.imageName())!.CGImage
            }
        }
    }
    
    var frontLayer: CALayer!
    var backLayer: CALayer!
    override var selected: Bool {
        didSet{
            frontLayer.hidden = !selected
            backLayer.hidden = selected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).CGColor
        
        self.frontLayer = CALayer()
        self.frontLayer.contents = UIImage(named: "ace_of_hearts")!.CGImage
        self.frontLayer.hidden = true
        self.layer.addSublayer(self.frontLayer)

        self.backLayer = CALayer()
        self.backLayer.contents = UIImage(named: "back")!.CGImage
        self.layer.addSublayer(self.backLayer)
    }
    
    override func layoutSubviews() {
        self.frontLayer.frame = CGRectInset(self.layer.bounds, 2, 2)
        self.backLayer.frame = self.layer.bounds
    }
}
